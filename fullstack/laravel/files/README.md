# {{PROJECT_NAME}}

A full-stack PHP application built with [Laravel](https://laravel.com/) 13.

## Getting Started

```bash
bash init.sh    # start MySQL, install dependencies, create .env, run migrations
bash run.sh     # start the development server
bash stop.sh    # stop the server
```

Open http://localhost:{{DEV_PORT}} in your browser. The framework health check is at `/up`.

## Testing

```bash
php artisan test
```

Tests run against an in-memory SQLite database (see `phpunit.xml`), so MySQL does not need to be running.

## Project Structure

```
app/
  Http/
    Controllers/
      Controller.php        # Base controller
      HomeController.php    # Homepage controller
  Models/
    User.php                # User model (Laravel default)
  Providers/
    AppServiceProvider.php  # Application service provider
bootstrap/
  app.php                   # Application bootstrap: routing, middleware, exceptions
  providers.php             # Registered service providers
routes/
  web.php                   # Web routes
resources/
  views/
    welcome.blade.php       # Homepage template
    layouts/
      app.blade.php         # Base layout
database/
  factories/                # Model factories (used by tests)
  migrations/               # Database migrations (users, sessions, cache, jobs)
public/
  index.php                 # HTTP entry point
tests/
  Feature/HomeTest.php      # Homepage and health check tests
artisan                     # Laravel CLI
phpunit.xml                 # Test configuration
docker-compose.yml          # MySQL container
```

## Requirements

- PHP 8.3+
- Composer
- Docker (for MySQL) or a local MySQL instance
