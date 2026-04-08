# Agent Instructions — {{CLI_NAME}}

This is a Python CLI tool built with Typer and Rich.

## Tech Stack
- **Language**: Python 3.11+
- **CLI Framework**: Typer (built on Click)
- **Output**: Rich (tables, colors, spinners)

## Key Conventions
- Entry point: `{{CLI_NAME}}/main.py`
- Commands in `{{CLI_NAME}}/commands/` — each module defines a Typer sub-app
- Uses `pyproject.toml` for project config and CLI entry point
- Rich console for styled output
- Type hints on all command parameters (Typer uses them for CLI args)

## File Patterns
- `{{CLI_NAME}}/main.py` → Root Typer app
- `{{CLI_NAME}}/commands/*.py` → Command groups
- `pyproject.toml` → Package config with `[project.scripts]` entry point
