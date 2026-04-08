import { db } from "../db/database";

interface Item {
  id: number;
  name: string;
  description: string;
  created_at: string;
}

export async function handleItems(req: Request, path: string): Promise<Response> {
  const idMatch = path.match(/^\/api\/items\/(\d+)$/);
  const id = idMatch ? parseInt(idMatch[1], 10) : null;

  switch (req.method) {
    case "GET": {
      if (id !== null) {
        const item = db.query("SELECT * FROM items WHERE id = ?").get(id) as Item | null;
        if (!item) return Response.json({ error: "Item not found" }, { status: 404 });
        return Response.json(item);
      }
      const items = db.query("SELECT * FROM items ORDER BY created_at DESC").all();
      return Response.json({ items });
    }

    case "POST": {
      const body = await req.json();
      if (!body.name) return Response.json({ error: "name required" }, { status: 400 });

      const result = db
        .query("INSERT INTO items (name, description) VALUES (?, ?) RETURNING *")
        .get(body.name, body.description || "") as Item;

      return Response.json(result, { status: 201 });
    }

    case "PUT": {
      if (id === null) return Response.json({ error: "ID required" }, { status: 400 });
      const body = await req.json();
      const existing = db.query("SELECT * FROM items WHERE id = ?").get(id) as Item | null;
      if (!existing) return Response.json({ error: "Item not found" }, { status: 404 });

      const updated = db
        .query("UPDATE items SET name = ?, description = ? WHERE id = ? RETURNING *")
        .get(body.name ?? existing.name, body.description ?? existing.description, id) as Item;

      return Response.json(updated);
    }

    case "DELETE": {
      if (id === null) return Response.json({ error: "ID required" }, { status: 400 });
      const item = db.query("SELECT * FROM items WHERE id = ?").get(id);
      if (!item) return Response.json({ error: "Item not found" }, { status: 404 });

      db.query("DELETE FROM items WHERE id = ?").run(id);
      return Response.json({ deleted: true });
    }

    default:
      return Response.json({ error: "Method not allowed" }, { status: 405 });
  }
}
