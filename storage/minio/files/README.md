# {{PROJECT_NAME}}

S3-compatible object storage with [MinIO](https://min.io/) — file uploads, presigned URLs, and bucket operations.

## Getting Started

```bash
bash init.sh    # install deps + start MinIO
bash run.sh     # start the API
bash stop.sh    # stop everything
```

## Services

| Service | URL | Credentials |
|---------|-----|-------------|
| API | `http://localhost:3000` | - |
| MinIO Console | `http://localhost:9001` | minioadmin / minioadmin |
| MinIO S3 API | `http://localhost:9000` | - |

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| POST | `/upload` | Upload a file (multipart/form-data) |
| GET | `/files` | List files in bucket |
| GET | `/files/:key` | Download a file |
| GET | `/files/:key/url` | Get a presigned download URL |
| DELETE | `/files/:key` | Delete a file |
| GET | `/health` | Health check |

## Project Structure

```
src/
  app.ts         # Express API
  minio.ts       # MinIO client setup
  storage.ts     # Storage operations (upload, list, download, presign)
docker-compose.yml
```

## Requirements

- Node.js 18+
- Docker
