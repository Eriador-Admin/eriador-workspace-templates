import express from "express";
import cors from "cors";
import itemRoutes from "./routes/items.js";

const app = express();

app.use(cors());
app.use(express.json());

app.get("/api/health", (_req, res) => {
  res.json({ status: "ok" });
});

app.use("/api/items", itemRoutes);

export default app;
