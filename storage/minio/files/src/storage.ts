import { Readable } from "stream";
import { minioClient, BUCKET } from "./minio.js";

export async function uploadFile(key: string, buffer: Buffer, contentType: string) {
  await minioClient.putObject(BUCKET, key, buffer, buffer.length, {
    "Content-Type": contentType,
  });
  return { key, size: buffer.length };
}

export async function listFiles(prefix = "") {
  const objects: { key: string; size: number; lastModified: Date }[] = [];
  const stream = minioClient.listObjects(BUCKET, prefix, true);

  return new Promise<typeof objects>((resolve, reject) => {
    stream.on("data", (obj) => {
      if (obj.name) {
        objects.push({ key: obj.name, size: obj.size, lastModified: obj.lastModified });
      }
    });
    stream.on("end", () => resolve(objects));
    stream.on("error", reject);
  });
}

export async function getFile(key: string): Promise<Readable> {
  return minioClient.getObject(BUCKET, key);
}

export async function getPresignedUrl(key: string, expirySeconds = 3600) {
  return minioClient.presignedGetObject(BUCKET, key, expirySeconds);
}

export async function deleteFile(key: string) {
  await minioClient.removeObject(BUCKET, key);
}
