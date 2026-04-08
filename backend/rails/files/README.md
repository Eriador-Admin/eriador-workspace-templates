# {{APP_NAME}}

A REST API built with [Ruby on Rails](https://rubyonrails.org/) (API-only mode).

## Getting Started

```bash
bash init.sh    # install gems and setup database
bash run.sh     # start dev server on port {{DEV_PORT}}
bash stop.sh    # stop the dev server
```

## Project Structure

```
app/
  controllers/    # API controllers
  models/         # ActiveRecord models
  serializers/    # JSON serializers
config/
  routes.rb       # Route definitions
db/
  migrate/        # Database migrations
  seeds.rb        # Seed data
spec/
  requests/       # Request specs
```

## API Endpoints

| Method | Path          | Description    |
|:-------|:--------------|:---------------|
| GET    | `/health`     | Health check   |
| GET    | `/api/v1/items` | List items   |
| POST   | `/api/v1/items` | Create item  |

## Testing

```bash
bundle exec rspec
```

## Requirements

- Ruby {{RUBY_VERSION}}+
- Bundler
- SQLite3 (development) or PostgreSQL (production)
