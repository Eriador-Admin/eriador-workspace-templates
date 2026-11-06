import { Readable } from "stream";
import {
  DeleteObjectCommand,
  GetObjectCommand,
  PutObjectCommand,
  paginateListObjectsV2,
} from "@aws-sdk/client-s3";
import { getSignedUrl } from "@aws-sdk/s3-request-presigner";
import { minioClient, BUCKET } from "./minio.js";

export async function uploadFile(key: string, buffer: Buffer, contentType: string) {
  await minioClient.send(
    new PutObjectCommand({
      Bucket: BUCKET,
      Key: key,
      Body: buffer,
      ContentLength: buffer.length,
      ContentType: contentType,
    })
  );
  return { key, size: buffer.length };
}

export async function listFiles(prefix = "") {
  const objects: { key: string; size: number; lastModified: Date | undefined }[] = [];
  for await (const page of paginateListObjectsV2({ client: minioClient }, { Bucket: BUCKET, Prefix: prefix })) {
    for (const obj of page.Contents ?? []) {
      if (obj.Key) {
        objects.push({ key: obj.Key, size: obj.Size ?? 0, lastModified: obj.LastModified });
      }
    }
  }
  return objects;
}

export async function getFile(key: string): Promise<Readable> {
  const { Body } = await minioClient.send(new GetObjectCommand({ Bucket: BUCKET, Key: key }));
  if (!(Body instanceof Readable)) throw new Error(`Object ${key} has no body`);
  return Body;
}

export async function getPresignedUrl(key: string, expirySeconds = 3600) {
  return getSignedUrl(minioClient, new GetObjectCommand({ Bucket: BUCKET, Key: key }), {
    expiresIn: expirySeconds,
  });
}

export async function deleteFile(key: string) {
  await minioClient.send(new DeleteObjectCommand({ Bucket: BUCKET, Key: key }));
}
