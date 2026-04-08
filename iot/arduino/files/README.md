# {{PROJECT_NAME}}

An Arduino project managed with [PlatformIO](https://platformio.org/).

## Getting Started

```bash
bash init.sh    # install PlatformIO CLI
bash run.sh     # build and upload to board
bash stop.sh    # (no-op for embedded)
```

## Project Structure

```
src/
  main.cpp        # Main Arduino sketch
include/          # Header files
lib/              # Project-specific libraries
platformio.ini    # PlatformIO configuration
```

## Commands

```bash
pio run                    # Build
pio run --target upload    # Build and upload
pio device monitor         # Serial monitor
```

## Requirements

- Python 3.11+ (for PlatformIO)
- USB cable for board upload
