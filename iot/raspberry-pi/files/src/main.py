"""{{PROJECT_NAME}} — Raspberry Pi GPIO demo."""

import os
import time
import signal
import sys
from dotenv import load_dotenv

load_dotenv()

try:
    import RPi.GPIO as GPIO
except ImportError:
    print("RPi.GPIO not available. Running in simulation mode.")
    GPIO = None

LED_PIN = int(os.getenv("LED_PIN", 18))
BUTTON_PIN = int(os.getenv("BUTTON_PIN", 23))

running = True


def cleanup(signum, frame):
    global running
    running = False
    if GPIO:
        GPIO.cleanup()
    print("\nCleanup complete. Exiting.")
    sys.exit(0)


signal.signal(signal.SIGINT, cleanup)
signal.signal(signal.SIGTERM, cleanup)


def setup():
    if not GPIO:
        return
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(LED_PIN, GPIO.OUT)
    GPIO.setup(BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)


def main():
    print(f"{{PROJECT_NAME}} started!")
    print(f"LED on GPIO {LED_PIN}, Button on GPIO {BUTTON_PIN}")
    setup()

    while running:
        if GPIO:
            GPIO.output(LED_PIN, GPIO.HIGH)
            print("LED ON")
            time.sleep(1)
            GPIO.output(LED_PIN, GPIO.LOW)
            print("LED OFF")
            time.sleep(1)
        else:
            print("[SIM] LED ON")
            time.sleep(1)
            print("[SIM] LED OFF")
            time.sleep(1)


if __name__ == "__main__":
    main()
