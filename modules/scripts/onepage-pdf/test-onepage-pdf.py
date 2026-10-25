#!/usr/bin/env python3
"""Integration checks: ONEPAGE_PDF=/path/to/onepage-pdf python3 test-onepage-pdf.py."""

import base64
import os
from pathlib import Path
import re
import subprocess
import tempfile
import unittest


class OnePagePdfTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="onepage-pdf-", dir="/tmp/opencode")
        self.addCleanup(self.temp.cleanup)
        self.directory = Path(self.temp.name)

    def run_script(self, *args):
        return subprocess.run(
            [os.environ.get("ONEPAGE_PDF", "onepage-pdf"), *map(str, args)],
            capture_output=True, text=True, timeout=60,
        )

    def convert(self, name, content, *options, expected_width=210 / 25.4 * 72,
                expected_pages=1):
        source = self.directory / name
        source.write_text(content)
        result = self.run_script(*options, source)
        self.assertEqual(result.returncode, 0, result.stderr)
        pdf = source.with_suffix(".pdf").read_bytes()
        self.assertTrue(pdf.startswith(b"%PDF-"))
        pages = len(re.findall(rb"/Type\s*/Page\b", pdf))
        if expected_pages is None:
            self.assertGreater(pages, 1)
        else:
            self.assertEqual(pages, expected_pages)
        box = re.search(rb"/MediaBox\s*\[([^]]+)\]", pdf)
        self.assertIsNotNone(box)
        _, _, width, height = map(float, box[1].split())
        self.assertAlmostEqual(width, expected_width, delta=1)
        return height, pdf

    def test_html_height_and_page_breaks(self):
        short, _ = self.convert("short.html", "<p>Short document</p>")
        tall, _ = self.convert("long.html", """
            <style>@page { size: A4; margin: 20mm; }
            p { break-before: page; height: 100px; }</style>
        """ + "<p>Another paragraph</p>" * 40)
        self.assertLess(short, 200)
        self.assertGreater(tall, 3000)

    def test_markdown_and_relative_image(self):
        (self.directory / "pixel.png").write_bytes(base64.b64decode(
            "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aK1sAAAAASUVORK5CYII="
        ))
        height, pdf = self.convert("notes with spaces.md", """
# Notes

![Local image](pixel.png)

| Name | Value |
| --- | --- |
| Test | 42 |

```python
print('hello')
```
""")
        self.assertGreater(height, 100)
        self.assertIn(b"/Subtype /Image", pdf)

    def test_invalid_input_and_no_overwrite(self):
        source = self.directory / "input.html"
        source.write_text("<p>Hello</p>")
        output = self.directory / "existing.pdf"
        output.write_bytes(b"keep me")
        self.assertNotEqual(self.run_script(source, output).returncode, 0)
        self.assertEqual(output.read_bytes(), b"keep me")
        self.assertNotEqual(self.run_script(self.directory / "missing.md").returncode, 0)
        self.assertNotEqual(self.run_script(source, source).returncode, 0)
        self.assertEqual(source.read_text(), "<p>Hello</p>")

    def test_paper_width_and_orientation(self):
        for paper, orientation, width in [
            ("A4", "portrait", 210 / 25.4 * 72),
            ("A4", "landscape", 297 / 25.4 * 72),
            ("tabloid", "portrait", 11 * 72),
            ("tabloid", "landscape", 17 * 72),
        ]:
            with self.subTest(paper=paper, orientation=orientation):
                self.convert(f"{paper}-{orientation}.md", "Hello", "--width", paper,
                             "--orientation", orientation, expected_width=width)

    def test_margins_and_wrapping(self):
        height, _ = self.convert("margins.html", """
            <style>body { margin: 0; }</style><div style="height: 24px">Hello</div>
        """)
        self.assertAlmostEqual(height, 144 + 25 * 0.75, delta=2)
        text = "Words that wrap across multiple lines. " * 100
        normal, _ = self.convert("normal.md", text)
        no_left, _ = self.convert("no-left.md", text, "--no-left-margin")
        self.assertLess(no_left, normal)

    def test_invalid_options(self):
        for options in [("--width", "Letter"), ("--width", "constructor"),
                        ("--orientation", "diagonal"), ("--unknown",)]:
            with self.subTest(options=options):
                result = self.run_script(*options, "input.md")
                self.assertNotEqual(result.returncode, 0)

    def test_split_paper_sizes(self):
        for paper, orientation, width, height in [
            ("A4", "portrait", 210 / 25.4 * 72, 297 / 25.4 * 72),
            ("A4", "landscape", 297 / 25.4 * 72, 210 / 25.4 * 72),
            ("tabloid", "portrait", 11 * 72, 17 * 72),
            ("tabloid", "landscape", 17 * 72, 11 * 72),
        ]:
            with self.subTest(paper=paper, orientation=orientation):
                _, pdf = self.convert(f"split-{paper}-{orientation}.md", "Paragraph.\n\n" * 100,
                                      "--split", "--width", paper, "--orientation", orientation,
                                      "--no-left-margin", expected_width=width, expected_pages=None)
                for box in re.findall(rb"/MediaBox\s*\[([^]]+)\]", pdf):
                    _, _, page_width, page_height = map(float, box.split())
                    self.assertAlmostEqual(page_width, width, delta=1)
                    self.assertAlmostEqual(page_height, height, delta=1)

    def test_split_preserves_html_page_breaks(self):
        height, _ = self.convert("split-break.html", """
            <style>@page { size: tabloid; margin: 0; }</style>
            <p>First page</p><p style="break-before: page">Second page</p>
        """, "--split", expected_pages=2)
        self.assertAlmostEqual(height, 297 / 25.4 * 72, delta=1)


if __name__ == "__main__":
    unittest.main()
