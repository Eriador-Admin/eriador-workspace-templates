# {{CLI_NAME}}

A CLI tool built with Go and [Cobra](https://github.com/spf13/cobra).

## Getting Started

```bash
bash init.sh    # download dependencies & build
bash run.sh     # run the CLI
bash stop.sh    # clean build artifacts
```

## Usage

```bash
./{{CLI_NAME}} greet --name "World"
./{{CLI_NAME}} greet --name "World" --shout
./{{CLI_NAME}} --help
```

## Project Structure

```
cmd/
  root.go           # Root command
  greet.go          # Greet subcommand
main.go             # Entry point
```

## Build

```bash
go build -o {{CLI_NAME}} .
```

## Requirements

- Go 1.21+
