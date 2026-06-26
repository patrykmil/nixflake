#!/usr/bin/env python3

import subprocess
import time


def get_current_hour() -> int:
    return time.localtime().tm_hour


def get_current_wallpaper():
    def current():
        return subprocess.run(["noctalia", "msg", "wallpaper-get"], capture_output=True, text=True)

    result = current()
    if result.returncode != 0:
        time.sleep(5)
        result = current()
        if result.returncode != 0:
            print(f"Error: noctalia wallpaper-get failed: {result.stderr.strip()}")
            raise SystemExit(1)

    wallpaper = result.stdout.strip()
    if not wallpaper:
        print("Error: noctalia wallpaper-get returned empty output")
        raise SystemExit(1)

    return wallpaper


def split_current_wallpaper() -> tuple[str, str, str]:
    wallpaper = get_current_wallpaper()

    wallpaper_dir = wallpaper.rsplit("/", 1)[0]
    filename = wallpaper.rsplit("/", 1)[-1]
    parts = filename.split(".")
    wallpaper_file = parts[0]
    wallpaper_extension = parts[1] if len(parts) > 1 else ""

    return wallpaper_dir, wallpaper_file, wallpaper_extension


def check_if_wallpaper_exists(full_path: str) -> bool:
    result = subprocess.run(["test", "-f", full_path], capture_output=True)
    return result.returncode == 0


def set_wallpaper_for_current_hour(path: str, file: str, extension: str):
    full_path = f"{path}/{file}.{extension}"
    if not check_if_wallpaper_exists(full_path):
        print(f"Error: Wallpaper file not found: {full_path}")
        raise SystemExit(1)

    subprocess.run(["noctalia", "msg", "wallpaper-set", full_path], check=True)
    print(f"Wallpaper set for hour {file}: {full_path}")


if __name__ == "__main__":
    print("Starting script")

    directory, file, extension = split_current_wallpaper()
    print(f"Current wallpaper directory: {directory}")
    print(f"Current wallpaper file: {file}")
    print(f"Current wallpaper extension: {extension}")

    if get_current_hour() == int(file):
        print("Wallpaper is already set for the current hour.")
    else:
        set_wallpaper_for_current_hour(directory, str(get_current_hour()), extension)
