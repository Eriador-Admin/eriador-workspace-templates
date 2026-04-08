import { Router, Request, Response } from "express";
import { search, advancedSearch } from "../services/search-service";

export const searchRouter = Router();

// Simple search via query params
searchRouter.get("/:index", async (req: Request, res: Response) => {
  try {
    const { q, from, size } = req.query;
    if (!q) return res.status(400).json({ error: "q parameter required" });

    const result = await search(
      req.params.index,
      q as string,
      parseInt(from as string) || 0,
      parseInt(size as string) || 10
    );

    res.json({
      total: (result.hits.total as any)?.value || 0,
      hits: result.hits.hits.map((h: any) => ({
        id: h._id,
        score: h._score,
        source: h._source,
      })),
    });
  } catch (err: any) {
    res.status(500).json({ error: err.message });
  }
});

// Advanced search via request body (Elasticsearch Query DSL)
searchRouter.post("/:index", async (req: Request, res: Response) => {
  try {
    const result = await advancedSearch(req.params.index, req.body);

    res.json({
      total: (result.hits.total as any)?.value || 0,
      hits: result.hits.hits.map((h: any) => ({
        id: h._id,
        score: h._score,
        source: h._source,
      })),
      aggregations: result.aggregations || undefined,
    });
  } catch (err: any) {
    res.status(500).json({ error: err.message });
  }
});
