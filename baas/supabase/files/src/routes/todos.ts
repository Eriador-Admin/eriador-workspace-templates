import { Router } from "express";
import { supabaseAdmin } from "../supabase.js";
import { requireAuth, type AuthRequest } from "../middleware/auth.js";

const router = Router();

router.get("/", requireAuth, async (req: AuthRequest, res) => {
  const { data, error } = await supabaseAdmin
    .from("todos")
    .select("*")
    .eq("user_id", req.user!.id)
    .order("created_at", { ascending: false });

  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

router.post("/", requireAuth, async (req: AuthRequest, res) => {
  const { title } = req.body;
  if (!title) return res.status(400).json({ error: "title is required" });

  const { data, error } = await supabaseAdmin
    .from("todos")
    .insert({ title, user_id: req.user!.id })
    .select()
    .single();

  if (error) return res.status(500).json({ error: error.message });
  res.status(201).json(data);
});

router.patch("/:id", requireAuth, async (req: AuthRequest, res) => {
  const { id } = req.params;
  const { title, completed } = req.body;

  const { data, error } = await supabaseAdmin
    .from("todos")
    .update({ ...(title !== undefined && { title }), ...(completed !== undefined && { completed }) })
    .eq("id", id)
    .eq("user_id", req.user!.id)
    .select()
    .single();

  if (error) return res.status(500).json({ error: error.message });
  res.json(data);
});

router.delete("/:id", requireAuth, async (req: AuthRequest, res) => {
  const { error } = await supabaseAdmin
    .from("todos")
    .delete()
    .eq("id", req.params.id)
    .eq("user_id", req.user!.id);

  if (error) return res.status(500).json({ error: error.message });
  res.status(204).end();
});

export default router;
