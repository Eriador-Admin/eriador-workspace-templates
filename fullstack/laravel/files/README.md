# {{PROJECT_NAME}}

A full-stack PHP application built with [Laravel](https://laravel.com/).

## Getting Started

```bash
bash init.sh    # install dependencies and set up database
bash run.sh     # start the development server
bash stop.sh    # stop the server
```

Open http://localhost:{{DEV_PORT}} in your browser.

## Project Structure

```
app/
  Http/
    Controllers/
      HomeController.php    # Homepage controller
  Models/
    User.php                # User model (Laravel default)
routes/
  web.php                   # Web routes
resources/
  views/
    welcome.blade.php       # Homepage template
    layouts/
      app.blade.php         # Base layout
database/
  migrations/               # Database migrations
docker-compose.yml          # MySQL container
```

## Requirements

- PHP 8.2+
- Composer
- Docker (for MySQL) or a local MySQL instance
