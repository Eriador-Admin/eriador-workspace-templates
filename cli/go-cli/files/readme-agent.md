# Agent Instructions — {{CLI_NAME}}

This is a Go CLI application built with Cobra.

## Tech Stack
- **Language**: Go 1.21+
- **CLI Framework**: Cobra (github.com/spf13/cobra)

## Key Conventions
- Entry point: `main.go` calls `cmd.Execute()`
- Root command in `cmd/root.go`
- Subcommands in `cmd/<name>.go` — registered in `init()` with `rootCmd.AddCommand()`
- Flags defined per-command or persistent on root
- Build output: single binary `./{{CLI_NAME}}`

## File Patterns
- `main.go` → Entry point
- `cmd/*.go` → Command definitions
- `go.mod` → Module dependencies
