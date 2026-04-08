# {{CLI_NAME}}

{{CLI_DESCRIPTION}}

## Getting Started

```bash
bash init.sh    # install dependencies & link CLI
bash run.sh     # run the CLI
bash stop.sh    # unlink the CLI
```

## Usage

```bash
{{CLI_NAME}} greet --name "World"
{{CLI_NAME}} greet --name "World" --shout
{{CLI_NAME}} --help
```

## Project Structure

```
src/
  index.ts          # CLI entry point
  commands/
    greet.ts        # Greet command
  utils/
    logger.ts       # Styled console output
```

## Development

```bash
npm run build       # compile TypeScript
npm run dev         # watch mode
npm link            # install CLI globally for testing
```
