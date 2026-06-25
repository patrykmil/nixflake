#!/usr/bin/env python3

import datetime
import subprocess


def get_current_hour() -> int:
    return datetime.datetime.now().hour


def get_current_wallpaper() -> tuple[str, str, str]:
    result = subprocess.run(["noctalia", "msg", "wallpaper-get"], capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Error: noctalia wallpaper-get failed: {result.stderr.strip()}")
        raise SystemExit(1)
    wallpaper = result.stdout.strip()
    if not wallpaper:
        print("Error: noctalia wallpaper-get returned empty output")
        raise SystemExit(1)
    wallpaper_dir = wallpaper.rsplit("/", 1)[0]
    filename = wallpaper.rsplit("/", 1)[-1]
    parts = filename.split(".")
    wallpaper_file = parts[0]
    wallpaper_extension = parts[1] if len(parts) > 1 else ""
    return wallpaper_dir, wallpaper_file, wallpaper_extension


def set_wallpaper_for_current_hour(path: str, file: str, extension: str):
    wallpaper_path = f"{path}/{file}.{extension}"
    subprocess.run(["noctalia", "msg", "wallpaper-set", wallpaper_path], check=True)
    print(f"Wallpaper set for hour {file}: {wallpaper_path}")


if __name__ == "__main__":
    print("Starting script")

    directory, file, extension = get_current_wallpaper()
    print(f"Current wallpaper directory: {directory}")
    print(f"Current wallpaper file: {file}")
    print(f"Current wallpaper extension: {extension}")

    if get_current_hour() == int(file):
        print("Wallpaper is already set for the current hour.")
    else:
        set_wallpaper_for_current_hour(directory, str(get_current_hour()), extension)
