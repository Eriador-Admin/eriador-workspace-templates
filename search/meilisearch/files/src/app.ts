import "dotenv/config";
import express from "express";
import { client } from "./client.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(express.json());

app.get("/health", async (_req, res) => {
  const health = await client.health();
  res.json(health);
});

app.get("/search", async (req, res) => {
  const q = (req.query.q as string) || "";
  const genre = req.query.genre as string | undefined;
  const limit = parseInt((req.query.limit as string) || "20", 10);

  const results = await client.index("movies").search(q, {
    limit,
    filter: genre ? `genre = "${genre}"` : undefined,
  });

  res.json(results);
});

app.post("/index", async (req, res) => {
  const doc = req.body;
  const task = await client.index("movies").addDocuments([doc]);
  res.json({ taskUid: task.taskUid });
});

app.listen(PORT, () => {
  console.log(`Search API: http://localhost:${PORT}/search?q=nolan`);
  console.log(`Meilisearch UI: http://localhost:7700`);
});
