import "dotenv/config";
import express from "express";
import authRoutes from "./routes/auth.js";
import todoRoutes from "./routes/todos.js";
import storageRoutes from "./routes/storage.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(express.json());

app.get("/health", (_req, res) => res.json({ status: "ok" }));

app.use("/auth", authRoutes);
app.use("/todos", todoRoutes);
app.use("/storage", storageRoutes);

app.listen(PORT, () => {
  console.log(`Supabase API: http://localhost:${PORT}`);
});
