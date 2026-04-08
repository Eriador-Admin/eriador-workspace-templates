# Agent Instructions — {{PROJECT_NAME}}

This is a MinIO object storage project.

## Tech Stack
- **Storage**: MinIO (S3-compatible)
- **Client**: minio npm package
- **App Server**: Express + TypeScript

## Key Conventions
- Entry point: `src/app.ts`
- MinIO client in `src/minio.ts`
- Storage operations in `src/storage.ts`
- Default bucket: "uploads" (auto-created on init)
- MinIO Console at port 9001, S3 API at port 9000
- All S3-compatible SDKs work with MinIO
