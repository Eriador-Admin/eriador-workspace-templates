# Agent Instructions — {{PROJECT_NAME}}

This is a MinIO object storage project.

## Tech Stack
- **Storage**: MinIO (S3-compatible)
- **Client**: AWS SDK v3 (`@aws-sdk/client-s3`, `@aws-sdk/s3-request-presigner`) pointed at MinIO with path-style addressing. The `minio` npm package was replaced because its latest release (8.0.7) pins vulnerable `query-string@7` and `stream-json@1`.
- **App Server**: Express 5 + TypeScript (uploads via Multer 2)
- **Typecheck**: `npm run typecheck`

## Key Conventions
- Entry point: `src/app.ts`
- MinIO client in `src/minio.ts`
- Storage operations in `src/storage.ts`
- Default bucket: "uploads" (auto-created on init)
- MinIO Console at port 9001, S3 API at port 9000
- All S3-compatible SDKs work with MinIO
