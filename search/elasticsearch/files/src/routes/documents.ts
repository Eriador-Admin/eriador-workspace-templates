import { Router, Request, Response } from "express";
import {
  indexDocument,
  getDocument,
  deleteDocument,
  bulkIndex,
} from "../services/document-service";

export const documentsRouter = Router();

documentsRouter.post("/:index", async (req: Request, res: Response) => {
  try {
    const result = await indexDocument(req.params.index, req.body);
    res.status(201).json({ id: result._id, index: result._index });
  } catch (err: any) {
    res.status(500).json({ error: err.message });
  }
});

documentsRouter.get("/:index/:id", async (req: Request, res: Response) => {
  try {
    const result = await getDocument(req.params.index, req.params.id);
    res.json({ id: result._id, source: result._source });
  } catch (err: any) {
    if (err.meta?.statusCode === 404) {
      return res.status(404).json({ error: "Document not found" });
    }
    res.status(500).json({ error: err.message });
  }
});

documentsRouter.delete("/:index/:id", async (req: Request, res: Response) => {
  try {
    await deleteDocument(req.params.index, req.params.id);
    res.json({ deleted: true });
  } catch (err: any) {
    res.status(500).json({ error: err.message });
  }
});

documentsRouter.post("/:index/_bulk", async (req: Request, res: Response) => {
  try {
    const { documents } = req.body;
    if (!Array.isArray(documents)) {
      return res.status(400).json({ error: "documents array required" });
    }
    const result = await bulkIndex(req.params.index, documents);
    res.json({
      took: result.took,
      errors: result.errors,
      items: result.items?.length,
    });
  } catch (err: any) {
    res.status(500).json({ error: err.message });
  }
});
