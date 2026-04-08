import { Router } from "express";
import { db } from "../firebase.js";
import { requireAuth, type AuthRequest } from "../middleware/auth.js";

const router = Router();
const notesCol = db.collection("notes");

router.get("/", requireAuth, async (req: AuthRequest, res) => {
  const snapshot = await notesCol
    .where("userId", "==", req.uid)
    .orderBy("createdAt", "desc")
    .get();

  const notes = snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
  res.json(notes);
});

router.post("/", requireAuth, async (req: AuthRequest, res) => {
  const { title, content } = req.body;
  if (!title) return res.status(400).json({ error: "title is required" });

  const doc = await notesCol.add({
    title,
    content: content || "",
    userId: req.uid,
    createdAt: new Date().toISOString(),
  });

  res.status(201).json({ id: doc.id, title, content: content || "" });
});

router.delete("/:id", requireAuth, async (req: AuthRequest, res) => {
  const doc = await notesCol.doc(req.params.id).get();
  if (!doc.exists || doc.data()?.userId !== req.uid) {
    return res.status(404).json({ error: "Note not found" });
  }

  await notesCol.doc(req.params.id).delete();
  res.status(204).end();
});

export default router;
