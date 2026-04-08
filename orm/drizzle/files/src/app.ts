import "dotenv/config";
import express from "express";
import { db } from "./db.js";
import { users, posts } from "./schema.js";
import { eq } from "drizzle-orm";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(express.json());

app.get("/health", (_req, res) => res.json({ status: "ok" }));

app.get("/users", async (_req, res) => {
  const result = await db.select().from(users);
  res.json(result);
});

app.post("/users", async (req, res) => {
  const { email, name } = req.body;
  if (!email) return res.status(400).json({ error: "email is required" });

  const [user] = await db.insert(users).values({ email, name }).returning();
  res.status(201).json(user);
});

app.get("/posts", async (_req, res) => {
  const result = await db
    .select({ id: posts.id, title: posts.title, content: posts.content, author: users.name })
    .from(posts)
    .leftJoin(users, eq(posts.authorId, users.id))
    .where(eq(posts.published, true));
  res.json(result);
});

app.post("/posts", async (req, res) => {
  const { title, content, authorId } = req.body;
  if (!title || !authorId) return res.status(400).json({ error: "title and authorId are required" });

  const [post] = await db.insert(posts).values({ title, content, authorId }).returning();
  res.status(201).json(post);
});

app.patch("/posts/:id/publish", async (req, res) => {
  const id = parseInt(req.params.id, 10);
  const [post] = await db.update(posts).set({ published: true }).where(eq(posts.id, id)).returning();
  res.json(post);
});

app.listen(PORT, () => {
  console.log(`Drizzle API: http://localhost:${PORT}`);
});
