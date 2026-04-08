# {{PACKAGE_NAME}}

{{PACKAGE_DESCRIPTION}}

## Getting Started

```bash
bash init.sh    # create venv and install in editable mode
bash run.sh     # run tests
```

## Development

```bash
source venv/bin/activate
pip install -e ".[dev]"    # install with dev dependencies
pytest                     # run tests
pytest --cov               # run tests with coverage
```

## Publishing

```bash
pip install build twine
python -m build
twine upload dist/*
```

## Project Structure

```
src/
  {{PACKAGE_NAME}}/
    __init__.py      # Package entry point
    utils.py         # Utility functions
tests/
  test_utils.py      # Tests
pyproject.toml       # Package configuration
```
