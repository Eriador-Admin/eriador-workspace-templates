# {{PROJECT_NAME}}

A REST API built with [Phoenix Framework](https://www.phoenixframework.org/) — a productive web framework for Elixir that delivers fault-tolerant, scalable applications with real-time capabilities.

## Getting Started

```bash
bash init.sh    # install deps, create/migrate database
bash run.sh     # start Phoenix server on port 4000
bash stop.sh    # stop server
```

## Prerequisites

- [Elixir](https://elixir-lang.org/install.html) 1.15+
- [Erlang/OTP](https://www.erlang.org/) 26+
- PostgreSQL running locally

### Install Elixir

**macOS:**
```bash
brew install elixir
```

**Ubuntu/Debian:**
```bash
sudo apt install elixir erlang
```

## Project Structure

```
mix.exs                         # Project config (deps, app name)
config/
  config.exs                    # Base config
  dev.exs                       # Dev environment config
  runtime.exs                   # Runtime config (env vars)
lib/
  app.ex                        # Application supervisor
  app/
    repo.ex                     # Ecto Repo (database)
    item.ex                     # Item schema + changeset
  app_web/
    endpoint.ex                 # HTTP endpoint (plugs pipeline)
    router.ex                   # Routes
    controllers/
      item_controller.ex        # CRUD controller
      fallback_controller.ex    # Error handler
    views/
      item_json.ex              # JSON serialization
      error_json.ex             # Error views
priv/
  repo/
    migrations/
      create_items.exs          # Database migration
test/
  test_helper.exs               # Test bootstrap
```

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | /api/items | List all items |
| GET | /api/items/:id | Get item by ID |
| POST | /api/items | Create item |
| PUT | /api/items/:id | Update item |
| DELETE | /api/items/:id | Delete item |
| GET | /api/health | Health check |

## Useful Commands

```bash
mix deps.get          # Install dependencies
mix ecto.create       # Create database
mix ecto.migrate      # Run migrations
mix phx.server        # Start server
iex -S mix phx.server # Start with interactive shell
mix test              # Run tests
mix phx.routes        # List all routes
```
