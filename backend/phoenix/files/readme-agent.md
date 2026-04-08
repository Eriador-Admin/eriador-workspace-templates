# Agent Instructions — {{PROJECT_NAME}}

This is a REST API built with Phoenix Framework in Elixir.

## Tech Stack
- **Language**: Elixir 1.15+
- **Framework**: Phoenix 1.7+
- **ORM**: Ecto 3.x
- **Database**: PostgreSQL

## Key Conventions
- Project config in `mix.exs`, environment configs in `config/`
- Business logic in `lib/app/`, web layer in `lib/app_web/`
- Schemas define database fields + changesets for validation
- Controllers handle HTTP, delegate to context modules
- JSON views render response shapes (Phoenix 1.7+ uses `*_json.ex`)
- Use `Ecto.Changeset` for all data validation — cast, validate_required, etc.
- Migrations in `priv/repo/migrations/` — generate with `mix ecto.gen.migration`
- Pattern match on function heads for control flow (Elixir convention)
- Use `with` for chaining operations that may fail
- Pipe operator `|>` for data transformation pipelines
- Processes and supervisors for concurrency — OTP patterns
