# {{CLI_NAME}}

{{CLI_DESCRIPTION}}

## Getting Started

```bash
bash init.sh    # create venv & install
bash run.sh     # run the CLI
bash stop.sh    # deactivate venv
```

## Usage

```bash
{{CLI_NAME}} greet "World"
{{CLI_NAME}} greet "World" --shout
{{CLI_NAME}} --help
```

## Project Structure

```
{{CLI_NAME}}/
  __init__.py
  main.py           # CLI entry point
  commands/
    greet.py        # Greet command
```

## Development

```bash
source venv/bin/activate
pip install -e ".[dev]"
{{CLI_NAME}} --help
```
