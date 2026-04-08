import { Router, Request, Response } from "express";
import { createIndex, deleteIndex } from "../services/index-service";

export const indicesRouter = Router();

indicesRouter.post("/", async (req: Request, res: Response) => {
  try {
    const { name, mappings } = req.body;
    if (!name) return res.status(400).json({ error: "name required" });
    const result = await createIndex(name, mappings);
    res.json({ acknowledged: true, index: name });
  } catch (err: any) {
    res.status(500).json({ error: err.message });
  }
});

indicesRouter.delete("/:name", async (req: Request, res: Response) => {
  try {
    await deleteIndex(req.params.name);
    res.json({ acknowledged: true });
  } catch (err: any) {
    res.status(500).json({ error: err.message });
  }
});
