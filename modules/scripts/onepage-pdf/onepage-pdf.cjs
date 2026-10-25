#!/usr/bin/env node

const fs = require('node:fs/promises');
const path = require('node:path');
const { pathToFileURL } = require('node:url');
const { execFileSync } = require('node:child_process');
const { parseArgs } = require('node:util');
const puppeteer = require('puppeteer');

async function main() {
  const { values, positionals: args } = parseArgs({
    allowPositionals: true,
    options: {
      width: { type: 'string', default: 'A4' },
      orientation: { type: 'string', default: 'portrait' },
      'no-left-margin': { type: 'boolean', default: false },
      split: { type: 'boolean', default: false },
      help: { type: 'boolean', short: 'h' },
    },
  });
  if (values.help) {
    console.log(`Usage: onepage-pdf [options] <file.html|file.md> [output.pdf]
  --width A4|tabloid                Paper width (default: A4)
  --orientation portrait|landscape  Use the paper's short or long edge (default: portrait)
  --no-left-margin                  Remove the left PDF margin
  --split                           Paginate onto standard-sized pages
Height is automatic; margins default to 1 inch on every side.
Output defaults to <file>.pdf; existing files are not overwritten.`);
    return;
  }
  const paper = { a4: [210 / 25.4 * 96, 297 / 25.4 * 96], tabloid: [11 * 96, 17 * 96] }[values.width.toLowerCase()];
  if (!['a4', 'tabloid'].includes(values.width.toLowerCase()) || !['portrait', 'landscape'].includes(values.orientation)) {
    throw new Error('Width must be A4 or tabloid; orientation must be portrait or landscape');
  }
  const width = paper[values.orientation === 'landscape' ? 1 : 0];
  const margin = { top: 96, right: 96, bottom: 96, left: values['no-left-margin'] ? 0 : 96 };
  if (args.length < 1 || args.length > 2) {
    throw new Error('Usage: onepage-pdf <file.html|file.md> [output.pdf]');
  }
  const input = path.resolve(args[0]);
  const extension = path.extname(input).toLowerCase();
  if (!['.html', '.htm', '.md', '.markdown'].includes(extension)) {
    throw new Error('Input must be an HTML or Markdown file');
  }
  const output = path.resolve(args[1] || input.slice(0, -extension.length) + '.pdf');
  if (path.extname(output).toLowerCase() !== '.pdf') {
    throw new Error('Output must have a .pdf extension');
  }
  let html = await fs.readFile(input, 'utf8');
  if (['.md', '.markdown'].includes(extension)) {
    const body = execFileSync(process.env.MARKDOWN_PYTHON || 'python3',
      ['-m', 'markdown', '-x', 'extra', input], { encoding: 'utf8', maxBuffer: 32 * 1024 * 1024 });
    html = `<!doctype html><html><head><meta charset="utf-8"><style>
      body { margin: 0; font: 16px/1.5 sans-serif; overflow-wrap: anywhere; }
      img { max-width: 100%; height: auto; }
      pre { white-space: pre-wrap; background: #f5f5f5; padding: 12px; }
      table { border-collapse: collapse; } th, td { border: 1px solid #ccc; padding: 6px; }
    </style></head><body>${body}</body></html>`;
  }

  const browser = await puppeteer.launch();
  let pdf;
  try {
    const page = await browser.newPage();
    // Match the PDF width before measuring, so text wraps identically.
    await page.setViewport({ width: Math.floor(width - margin.left - margin.right), height: 1 });
    await page.emulateMedia('screen');
    await page.setJavaScriptEnabled(false);
    // Serve the converted document at its original URL, preserving relative assets.
    await page.setRequestInterception(true);
    const url = pathToFileURL(input).href;
    page.on('request', request => {
      if (request.isNavigationRequest() && request.url() === url) {
        request.respond({ contentType: 'text/html; charset=utf-8', body: html });
      } else {
        request.continue();
      }
    });
    await page.goto(url, { waitUntil: 'networkidle0', timeout: 30000 });
    await page.evaluate((margin, split) => {
      const style = document.createElement('style');
      style.textContent = `
      @page { size: auto !important;
              margin: ${margin.top}px ${margin.right}px ${margin.bottom}px ${margin.left}px !important; }
       ${split ? '' : `* { break-before: auto !important; break-after: auto !important;
           page-break-before: auto !important; page-break-after: auto !important; }`}
      html { -webkit-print-color-adjust: exact; }
      `;
      document.head.appendChild(style);
    }, margin, values.split);
    await page.evaluate(async () => {
      await document.fonts.ready;
      await Promise.all(Array.from(document.images, image => {
        image.loading = 'eager';
        return image.decode().catch(() => {});
      }));
    });
    const height = values.split ? paper[values.orientation === 'landscape' ? 0 : 1]
      : await page.evaluate(() => Math.ceil(Math.max(
      document.documentElement.scrollHeight,
      document.body ? document.body.scrollHeight : 0
    )) + 1) + margin.top + margin.bottom;
    // shortcut: viewport-height layouts use the initial viewport, use content-sized HTML for long documents.
    pdf = await page.pdf({
      width: `${width}px`, height: `${height}px`,
      margin, printBackground: true,
    });
  } finally {
    await browser.close();
  }
  await fs.writeFile(output, pdf, { flag: 'wx' });
  console.log(output);
}

main().catch(error => {
  console.error(`onepage-pdf: ${error.message}`);
  process.exitCode = 1;
});
