import { Router } from "express";
import multer from "multer";
import { supabaseAdmin } from "../supabase.js";
import { requireAuth, type AuthRequest } from "../middleware/auth.js";

const router = Router();
const upload = multer({ storage: multer.memoryStorage(), limits: { fileSize: 10 * 1024 * 1024 } });

router.post("/upload", requireAuth, upload.single("file"), async (req: AuthRequest, res) => {
  if (!req.file) return res.status(400).json({ error: "No file provided" });

  const path = `${req.user!.id}/${Date.now()}-${req.file.originalname}`;
  const { data, error } = await supabaseAdmin.storage
    .from("uploads")
    .upload(path, req.file.buffer, { contentType: req.file.mimetype });

  if (error) return res.status(500).json({ error: error.message });

  const { data: urlData } = supabaseAdmin.storage
    .from("uploads")
    .getPublicUrl(data.path);

  res.json({ path: data.path, url: urlData.publicUrl });
});

export default router;
