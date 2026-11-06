# Agent Instructions — {{PROJECT_NAME}}

This is a Laravel PHP full-stack application.

## Tech Stack
- **Framework**: Laravel 13
- **Language**: PHP 8.3+
- **Template Engine**: Blade
- **ORM**: Eloquent
- **Database**: MySQL (via Docker); tests use in-memory SQLite
- **Tests**: PHPUnit 12 via `php artisan test`

## Key Conventions
- Application bootstrap (routing, middleware, exception handling): `bootstrap/app.php`
- Service providers: `bootstrap/providers.php` and `app/Providers/`
- Routes: `routes/web.php` (web). For an API, run `php artisan install:api` to add `routes/api.php`
- Controllers: `app/Http/Controllers/` (extend `App\Http\Controllers\Controller`)
- Models: `app/Models/`
- Views: `resources/views/` with `.blade.php` extension
- Migrations: `database/migrations/`; factories: `database/factories/`
- Tests: `tests/Feature/` (configuration in `phpunit.xml`)
- Config: `.env` file (copy from `.env.example`). Framework config defaults apply; run `php artisan config:publish` to publish a config file you need to change
- Sessions, cache and queue use the database driver (tables created by the default migrations)
- Health check: `GET /up`
- Use `php artisan` for CLI commands

## Commands
- `bash init.sh` — start MySQL, `composer install`, create `.env` + app key, migrate
- `bash run.sh` — `php artisan serve`
- `php artisan test` — run the test suite
- `composer audit` — check installed packages for security advisories
