import "dotenv/config";
import express from "express";
import authRoutes from "./routes/auth.js";
import noteRoutes from "./routes/notes.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(express.json());

app.get("/health", (_req, res) => res.json({ status: "ok" }));

app.use("/auth", authRoutes);
app.use("/notes", noteRoutes);

app.listen(PORT, () => {
  console.log(`Firebase API: http://localhost:${PORT}`);
  if (process.env.FIRESTORE_EMULATOR_HOST) {
    console.log(`Emulator UI: http://localhost:4000`);
  }
});
