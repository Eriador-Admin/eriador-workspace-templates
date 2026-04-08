import "dotenv/config";
import express from "express";
import { searchRouter } from "./routes/search";
import { documentsRouter } from "./routes/documents";
import { indicesRouter } from "./routes/indices";
import { elasticClient } from "./services/elastic";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(express.json());

app.use("/api/search", searchRouter);
app.use("/api/documents", documentsRouter);
app.use("/api/indices", indicesRouter);

app.get("/api/health", async (_req, res) => {
  try {
    const info = await elasticClient.info();
    res.json({ status: "ok", elasticsearch: info.version.number });
  } catch (err: any) {
    res.status(503).json({ status: "error", message: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`{{PROJECT_NAME}} running on http://localhost:${PORT}`);
});
