# Agent Instructions — {{APP_NAME}}

This is a Ruby on Rails API-only application.

## Tech Stack
- **Framework**: Rails 7.x (API-only)
- **ORM**: ActiveRecord
- **Testing**: RSpec
- **Language**: Ruby {{RUBY_VERSION}}+

## Key Conventions
- API-only mode (no views, no asset pipeline)
- Controllers in `app/controllers/api/v1/` for versioned endpoints
- Models in `app/models/` with ActiveRecord
- Database migrations in `db/migrate/`
- Routes in `config/routes.rb`
- Tests in `spec/` using RSpec

## File Patterns
- `app/controllers/api/v1/*.rb` → Versioned API controllers
- `app/models/*.rb` → ActiveRecord models
- `db/migrate/*_*.rb` → Database migrations
- `spec/requests/*.rb` → Request (integration) specs
