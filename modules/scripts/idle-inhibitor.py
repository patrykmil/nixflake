#!/usr/bin/env python3
import os
import subprocess
import sys
import time


def print_usage(error: bool = False):
    message = """
\033[1m\033[4m\033[96mIdle Inhibitor\033[0m — Prevent system idle

Usage: idle-inhibitor [command]

Options:
  -h, --help                  Print this help message and exit

Commands:
  (no command)                 Check inhibition status
  <minutes>                    Set inhibition for minutes
  kill, k                      Kill current inhibition
                 """

    if error:
        sys.exit(message)
    else:
        sys.stdout.write(message)
        sys.exit(0)


STATUS_FILE = os.path.expanduser("~/.config/idle_inhibit_status.txt")


def check_status() -> tuple[bool, str]:
    if os.path.exists(STATUS_FILE):
        with open(STATUS_FILE, "r") as f:
            parts = f.read().strip().split()
            if len(parts) == 2:
                start, duration = map(int, parts)
                now = int(time.time())
                elapsed = now - start
                if elapsed < duration:
                    left = duration - elapsed
                    return True, f"Time left: {left // 60} minutes and {left % 60} seconds"
                else:
                    os.remove(STATUS_FILE)
                    return False, "No active inhibition"
            else:
                return False, "Invalid status file"
    else:
        return False, "No active inhibition"


def kill_inhibition():
    subprocess.run(["pkill", "-f", "systemd-inhibit.*idle"], check=False)
    if os.path.exists(STATUS_FILE):
        os.remove(STATUS_FILE)
    print("Inhibition killed")


def set_inhibition(minutes: int):
    if check_status()[0]:
        kill_inhibition()
    subprocess.Popen(
        ["systemd-inhibit", "sleep", str(minutes * 60)],
    )
    with open(STATUS_FILE, "w") as f:
        f.write(f"{int(time.time())} {minutes * 60}\n")
    print(f"Inhibition set for {minutes} minutes")


if __name__ == "__main__":
    if len(sys.argv) == 1:
        print(check_status()[1])
    elif len(sys.argv) == 2:
        arg = sys.argv[1]
        if arg in ["help", "--help", "-h"]:
            print_usage()
        elif arg in ["k", "kill"]:
            kill_inhibition()
        elif arg.isdigit():
            set_inhibition(int(arg))
        else:
            print_usage()
    else:
        print_usage()
