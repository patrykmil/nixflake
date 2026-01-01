#!/usr/bin/env python3
import os
import subprocess
import sys


def set_gamma(value: str):
    subprocess.Popen(
        ["hyprctl", "hyprsunset", "gamma", value],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def set_temperature(value: str):
    subprocess.Popen(
        ["hyprctl", "hyprsunset", "temperature", value],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def print_usage(error: bool = False):
    message = """
\033[1m\033[4m\033[96mBright\033[0m — Control display brightness and temperature

Usage: bright [command] [value]

Options:
  -h, --help                  Print this help message and exit

Commands:
  (no command)                 Apply saved gamma and temperature
  <gamma>                      Set gamma and save
  gamma <value>                Set gamma and save
  temp <value>                 Set temperature and save
  reset                        Reset to default values
                 """

    if error:
        sys.exit(message)
    else:
        sys.stdout.write(message)
        sys.exit(0)


DEFAULT_GAMMA = "67"
DEFAULT_TEMP = "5500"

HOME = os.path.expanduser("~")
CONFIG_FILE = os.path.join(HOME, ".config", "brightness.conf")
os.makedirs(os.path.dirname(CONFIG_FILE), exist_ok=True)


def load_config() -> dict:
    if not os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, "w") as f:
            f.write(f"gamma:{DEFAULT_GAMMA}\ntemp:{DEFAULT_TEMP}\n")
    config = {}
    with open(CONFIG_FILE, "r") as f:
        for line in f:
            line = line.strip()
            if ":" in line:
                key, value = line.split(":", 1)
                config[key] = value
    return config


def save_config(config: dict):
    with open(CONFIG_FILE, "w") as f:
        for key in ["gamma", "temp"]:
            if key in config:
                f.write(f"{key}:{config[key]}\n")


if __name__ == "__main__":
    config = load_config()
    arg_count = len(sys.argv) - 1
    if arg_count == 0:
        if "gamma" not in config or "temp" not in config:
            sys.exit(f"Missing values in {CONFIG_FILE} and no argument provided.\nCurrent config: {config}")
        set_gamma(config["gamma"])
        set_temperature(config["temp"])
    elif arg_count == 1:
        arg = sys.argv[1]
        if arg in ["help", "--help", "-h"]:
            print_usage()
        elif arg == "reset":
            config["gamma"] = DEFAULT_GAMMA
            config["temp"] = DEFAULT_TEMP
            save_config(config)
            set_gamma(DEFAULT_GAMMA)
            set_temperature(DEFAULT_TEMP)
        else:
            config["gamma"] = arg
            save_config(config)
            set_gamma(arg)
    elif arg_count == 2:
        cmd, val = sys.argv[1], sys.argv[2]
        if cmd == "gamma":
            config["gamma"] = val
            save_config(config)
            set_gamma(val)
        elif cmd == "temp":
            config["temp"] = val
            save_config(config)
            set_temperature(val)
        else:
            print_usage(error=True)
    else:
        print_usage(error=True)
