#!/usr/bin/env python3

import datetime
import subprocess


def get_current_hour() -> int:
    return datetime.datetime.now().hour


def get_current_wallpaper() -> tuple[str, str, str]:
    result = subprocess.run(["noctalia", "msg", "wallpaper-get"], capture_output=True, text=True)
    wallpaper = result.stdout.strip()
    wallpaper_dir = wallpaper.rsplit("/", 1)[0]
    wallpaper_file = wallpaper.rsplit("/", 1)[-1].split(".")[0]
    wallpaper_extension = wallpaper.rsplit("/", 1)[-1].split(".")[1]
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
