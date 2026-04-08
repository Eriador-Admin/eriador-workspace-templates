# Agent Instructions — {{SERVICE_NAME}}

This is a NestJS microservice with hybrid HTTP + TCP transport.

## Tech Stack
- **Framework**: NestJS
- **Language**: TypeScript
- **Transports**: HTTP (Express) + TCP microservice

## Key Conventions
- Hybrid app: serves both HTTP requests and TCP message patterns
- Feature modules in `src/<feature>/` with module, controller, service
- DTOs for validation in `dto/` subdirectories
- `@MessagePattern()` for TCP handlers, `@Get()`/`@Post()` for HTTP
- Module-based dependency injection

## File Patterns
- `src/main.ts` → Bootstrap with hybrid app (HTTP + TCP)
- `src/app.module.ts` → Root module importing feature modules
- `src/<feature>/<feature>.module.ts` → Feature module
- `src/<feature>/<feature>.controller.ts` → Handlers
- `src/<feature>/<feature>.service.ts` → Business logic
- `src/<feature>/dto/*.dto.ts` → Data transfer objects
