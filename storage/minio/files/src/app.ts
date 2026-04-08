import "dotenv/config";
import express from "express";
import multer from "multer";
import { ensureBucket } from "./minio.js";
import { uploadFile, listFiles, getFile, getPresignedUrl, deleteFile } from "./storage.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);
const upload = multer({ storage: multer.memoryStorage(), limits: { fileSize: 50 * 1024 * 1024 } });

app.get("/health", (_req, res) => res.json({ status: "ok" }));

app.post("/upload", upload.single("file"), async (req, res) => {
  if (!req.file) return res.status(400).json({ error: "No file provided" });

  const key = `${Date.now()}-${req.file.originalname}`;
  const result = await uploadFile(key, req.file.buffer, req.file.mimetype);
  res.json(result);
});

app.get("/files", async (_req, res) => {
  const files = await listFiles();
  res.json(files);
});

app.get("/files/:key", async (req, res) => {
  try {
    const stream = await getFile(req.params.key);
    stream.pipe(res);
  } catch {
    res.status(404).json({ error: "File not found" });
  }
});

app.get("/files/:key/url", async (req, res) => {
  try {
    const url = await getPresignedUrl(req.params.key);
    res.json({ url });
  } catch {
    res.status(404).json({ error: "File not found" });
  }
});

app.delete("/files/:key", async (req, res) => {
  await deleteFile(req.params.key);
  res.status(204).end();
});

async function start() {
  await ensureBucket();
  app.listen(PORT, () => {
    console.log(`Storage API: http://localhost:${PORT}`);
    console.log(`MinIO Console: http://localhost:9001`);
  });
}

start();
