# Agent Instructions — {{APP_NAME}}

This is an ASP.NET Core Web API project.

## Tech Stack
- **Framework**: ASP.NET Core 8
- **ORM**: Entity Framework Core
- **Testing**: xUnit
- **Language**: C# 12

## Key Conventions
- Minimal hosting in `Program.cs`
- Controllers in `Controllers/` with `[ApiController]` attribute
- Models in `Models/` — POCOs for data
- DbContext in `Data/AppDbContext.cs`
- Services registered via dependency injection in `Program.cs`
- Swagger/OpenAPI enabled in development

## File Patterns
- `Controllers/*Controller.cs` → API endpoints
- `Models/*.cs` → Data transfer objects and entities
- `Data/*.cs` → EF Core context and configuration
- `*.csproj` → Project file with NuGet references
