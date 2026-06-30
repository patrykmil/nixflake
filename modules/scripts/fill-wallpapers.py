#!/usr/bin/env python3

import os
import re

WALLPAPERS_DIR = "/home/ptrk/wallpapers"
NUM_PATTERN = re.compile(r"^(\d+)\.(jpg|png)$")
for entry in sorted(os.listdir(WALLPAPERS_DIR)):
    print(entry)
    subdir = os.path.join(WALLPAPERS_DIR, entry)
    if not os.path.isdir(subdir):
        continue
    print(subdir)
    existing = {}
    for f in os.listdir(subdir):
        m = NUM_PATTERN.match(f)
        if m:
            num = int(m.group(1))
            existing[num] = m.group(2)
    if not existing:
        continue
    ext = existing[max(existing)]
    for n in range(0, 24):
        if n in existing:
            continue
        lower = [k for k in existing if k < n]
        target = max(lower) if lower else max(existing)
        src = f"{target}.{ext}"
        link = f"{n}.{ext}"
        link_path = os.path.join(subdir, link)
        if not os.path.exists(link_path):
            os.symlink(src, link_path)
            print(f"  {entry}/{link} -> {src}")
