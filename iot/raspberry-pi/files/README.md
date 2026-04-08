# {{PROJECT_NAME}}

A Raspberry Pi project with Python for GPIO control and sensor reading.

## Getting Started

```bash
bash init.sh    # create venv & install deps
bash run.sh     # run the main script
bash stop.sh    # stop the script
```

## Project Structure

```
src/
  main.py         # Main application entry point
  gpio_control.py # GPIO pin control utilities
  sensors.py      # Sensor reading helpers
```

## Wiring

Default pin assignments (BCM numbering):
- **LED**: GPIO 18
- **Button**: GPIO 23

## Requirements

- Raspberry Pi (any model with GPIO)
- Python 3.9+
- RPi.GPIO library (included in Raspberry Pi OS)
