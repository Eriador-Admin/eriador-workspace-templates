import { CreateBucketCommand, HeadBucketCommand, S3Client, S3ServiceException } from "@aws-sdk/client-s3";

const endPoint = process.env.MINIO_ENDPOINT || "localhost";
const port = parseInt(process.env.MINIO_PORT || "9000", 10);

// MinIO speaks the S3 API: path-style addressing, any region name, and checksums only when S3 requires them.
export const minioClient = new S3Client({
  endpoint: `http://${endPoint}:${port}`,
  region: process.env.MINIO_REGION || "us-east-1",
  forcePathStyle: true,
  requestChecksumCalculation: "WHEN_REQUIRED",
  responseChecksumValidation: "WHEN_REQUIRED",
  credentials: {
    accessKeyId: process.env.MINIO_ACCESS_KEY || "minioadmin",
    secretAccessKey: process.env.MINIO_SECRET_KEY || "minioadmin",
  },
});

export const BUCKET = process.env.MINIO_BUCKET || "uploads";

export async function ensureBucket() {
  try {
    await minioClient.send(new HeadBucketCommand({ Bucket: BUCKET }));
  } catch (err) {
    if (!(err instanceof S3ServiceException) || err.$metadata.httpStatusCode !== 404) throw err;
    await minioClient.send(new CreateBucketCommand({ Bucket: BUCKET }));
    console.log(`Bucket "${BUCKET}" created`);
  }
}
