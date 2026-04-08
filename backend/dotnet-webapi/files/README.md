# {{APP_NAME}}

An ASP.NET Core Web API with [Entity Framework Core](https://docs.microsoft.com/en-us/ef/core/).

## Getting Started

```bash
bash init.sh    # restore packages
bash run.sh     # start dev server on port {{DEV_PORT}}
bash stop.sh    # stop the dev server
```

## Project Structure

```
Controllers/     # API controllers
Models/          # Data models
Data/            # DbContext and migrations
Services/        # Business logic
Program.cs       # Application entry point
```

## API Endpoints

| Method | Path            | Description     |
|:-------|:----------------|:----------------|
| GET    | `/health`       | Health check    |
| GET    | `/api/items`    | List items      |
| POST   | `/api/items`    | Create item     |

## Swagger

Visit `http://localhost:{{DEV_PORT}}/swagger` when running in development.

## Requirements

- [.NET 8 SDK](https://dotnet.microsoft.com/download)
