import { Hono } from "hono";
import { zValidator } from "@hono/zod-validator";
import { createItemSchema, updateItemSchema } from "../validators/item";

interface Item {
  id: string;
  name: string;
  description: string;
  createdAt: string;
}

const items: Map<string, Item> = new Map();
let nextId = 1;

export const itemsRoute = new Hono();

// List all items
itemsRoute.get("/", (c) => {
  return c.json({ items: Array.from(items.values()) });
});

// Get item by ID
itemsRoute.get("/:id", (c) => {
  const item = items.get(c.req.param("id"));
  if (!item) return c.json({ error: "Item not found" }, 404);
  return c.json(item);
});

// Create item
itemsRoute.post("/", zValidator("json", createItemSchema), (c) => {
  const body = c.req.valid("json");
  const id = String(nextId++);
  const item: Item = {
    id,
    name: body.name,
    description: body.description || "",
    createdAt: new Date().toISOString(),
  };
  items.set(id, item);
  return c.json(item, 201);
});

// Update item
itemsRoute.put("/:id", zValidator("json", updateItemSchema), (c) => {
  const id = c.req.param("id");
  const existing = items.get(id);
  if (!existing) return c.json({ error: "Item not found" }, 404);

  const body = c.req.valid("json");
  const updated: Item = {
    ...existing,
    name: body.name ?? existing.name,
    description: body.description ?? existing.description,
  };
  items.set(id, updated);
  return c.json(updated);
});

// Delete item
itemsRoute.delete("/:id", (c) => {
  const id = c.req.param("id");
  if (!items.has(id)) return c.json({ error: "Item not found" }, 404);
  items.delete(id);
  return c.json({ deleted: true });
});
