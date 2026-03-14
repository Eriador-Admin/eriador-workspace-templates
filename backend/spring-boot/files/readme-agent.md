# Agent Reference — Spring Boot

## Overview

Java REST API built with Spring Boot 3 and Maven. Includes CORS configuration, a health endpoint, and item CRUD controller. Runs as an embedded Tomcat server packaged into a single JAR.

## Tech Stack

- **Spring Boot 3.3** — Java application framework with auto-configuration
- **Spring Web** — REST controller and servlet support
- **Maven 3.9+** — Build and dependency management
- **Java 17+** — Language runtime (LTS)

## Prerequisites

- Java >= 17 (JDK, not just JRE)
- Maven >= 3.9

## Project Structure

```
pom.xml                                           — Maven build file (dependencies, plugins, Spring Boot parent)
src/main/java/com/example/Application.java        — Entry point: @SpringBootApplication, CORS config bean
src/main/java/com/example/controller/HealthController.java — GET /health endpoint
src/main/java/com/example/controller/ItemController.java   — Item CRUD endpoints
src/main/resources/application.properties         — Spring Boot configuration (server.port)
.env.example                                      — Environment variable defaults for Docker/scripts
init.sh                                           — Build project and setup .env
run.sh                                            — Start via Maven with .env variables loaded
stop.sh                                           — Stop the running server
Dockerfile                                        — Multi-stage production build (maven + JRE)
```

## Environment Variables

Spring Boot reads configuration from `application.properties`, which supports environment variable interpolation with `${VAR:default}` syntax.

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `SERVER_PORT` | No | `8080` | Port the embedded Tomcat server listens on. Maps to `server.port` in `application.properties` |
| `CORS_ORIGIN` | No | `http://localhost:5173` | Allowed origin for CORS requests. Read in `Application.java` via `System.getenv()` |

The `.env.example` file uses the `KEY=VALUE` convention. The `run.sh` script sources `.env` as OS environment variables, which Spring Boot picks up via `${VAR:default}` in `application.properties`.

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Run `mvn clean install -DskipTests` to compile and download dependencies, copy `.env.example` to `.env` | `bash init.sh` |
| `run.sh` | Source `.env` as environment variables, then run `mvn spring-boot:run` | `bash run.sh` |
| `stop.sh` | Stop the running server by killing the process on the configured SERVER_PORT | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

The server starts at `http://localhost:8080`.

For a packaged JAR:

```bash
mvn package -DskipTests
java -jar target/*.jar
```

## Docker Deployment

Build and run the production container:

```bash
docker build -t spring-boot-api .
docker run -d -p 8080:8080 \
  -e SERVER_PORT=8080 \
  -e CORS_ORIGIN=https://your-frontend.com \
  --name spring-boot-api spring-boot-api
```

Or use an env file:

```bash
docker run -d -p 8080:8080 --env-file .env --name spring-boot-api spring-boot-api
```

The Dockerfile uses a multi-stage build:
1. **Stage 1 (maven:3.9-eclipse-temurin-17):** Caches dependencies via `mvn dependency:go-offline`, then packages the JAR.
2. **Stage 2 (eclipse-temurin:17-jre):** Copies only the JAR file. Final image is ~250 MB.

## Health Check

```bash
curl -s http://localhost:8080/health
```

Expected response: `{"status":"ok"}`

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/health` | Health check |
| GET | `/api/items` | List all items |
| POST | `/api/items` | Create a new item |

## Customization

- **Add controllers:** Create new `@RestController` classes in `src/main/java/com/example/controller/`
- **Add services:** Create `@Service` classes in a `service/` package and inject with `@Autowired`
- **Add database:** Add `spring-boot-starter-data-jpa` and a JDBC driver to `pom.xml`, configure `spring.datasource.*` in `application.properties`
- **Change port:** Set `SERVER_PORT` in `.env` or `server.port` in `application.properties`
- **Rename package:** Update package declarations, `pom.xml` groupId/artifactId, and the `Application.java` path
