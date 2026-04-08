import "dotenv/config";
import express from "express";
import { prisma } from "./prisma.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(express.json());

app.get("/health", (_req, res) => res.json({ status: "ok" }));

app.get("/users", async (_req, res) => {
  const users = await prisma.user.findMany({ include: { posts: true } });
  res.json(users);
});

app.post("/users", async (req, res) => {
  const { email, name } = req.body;
  if (!email) return res.status(400).json({ error: "email is required" });

  const user = await prisma.user.create({ data: { email, name } });
  res.status(201).json(user);
});

app.get("/posts", async (_req, res) => {
  const posts = await prisma.post.findMany({
    where: { published: true },
    include: { author: { select: { name: true, email: true } } },
  });
  res.json(posts);
});

app.post("/posts", async (req, res) => {
  const { title, content, authorId } = req.body;
  if (!title || !authorId) {
    return res.status(400).json({ error: "title and authorId are required" });
  }

  const post = await prisma.post.create({ data: { title, content, authorId } });
  res.status(201).json(post);
});

app.patch("/posts/:id/publish", async (req, res) => {
  const id = parseInt(req.params.id, 10);
  const post = await prisma.post.update({
    where: { id },
    data: { published: true },
  });
  res.json(post);
});

app.listen(PORT, () => {
  console.log(`Prisma API: http://localhost:${PORT}`);
});
