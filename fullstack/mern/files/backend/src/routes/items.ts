import { Router } from "express";
import { Item } from "../models/Item.js";

const router = Router();

router.get("/", async (_req, res) => {
  const items = await Item.find().sort({ createdAt: -1 });
  res.json(items);
});

router.post("/", async (req, res) => {
  const item = await Item.create(req.body);
  res.status(201).json(item);
});

router.put("/:id", async (req, res) => {
  const item = await Item.findByIdAndUpdate(req.params.id, req.body, { new: true });
  if (!item) return res.status(404).json({ error: "Not found" });
  res.json(item);
});

router.delete("/:id", async (req, res) => {
  const item = await Item.findByIdAndDelete(req.params.id);
  if (!item) return res.status(404).json({ error: "Not found" });
  res.json({ deleted: true });
});

export default router;
