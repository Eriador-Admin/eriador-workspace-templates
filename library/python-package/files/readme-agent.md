# Agent Instructions — {{PACKAGE_NAME}}

This is a Python package project.

## Tech Stack
- **Language**: Python 3.11+
- **Build**: setuptools via pyproject.toml
- **Testing**: pytest

## Key Conventions
- Source layout: `src/{{PACKAGE_NAME}}/`
- Tests in `tests/` using pytest
- Configuration in `pyproject.toml` (PEP 621)
- Editable install: `pip install -e ".[dev]"`

## File Patterns
- `src/{{PACKAGE_NAME}}/*.py` → Package source
- `tests/test_*.py` → Test files
- `pyproject.toml` → Build config, dependencies, metadata
