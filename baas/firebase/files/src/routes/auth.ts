import { Router } from "express";
import { auth } from "../firebase.js";

const router = Router();

router.post("/signup", async (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({ error: "email and password are required" });
  }

  try {
    const user = await auth.createUser({ email, password });
    const token = await auth.createCustomToken(user.uid);
    res.json({ uid: user.uid, customToken: token });
  } catch (err) {
    const message = err instanceof Error ? err.message : "Signup failed";
    res.status(400).json({ error: message });
  }
});

router.post("/login", async (req, res) => {
  const { email } = req.body;
  if (!email) {
    return res.status(400).json({ error: "email is required" });
  }

  try {
    const user = await auth.getUserByEmail(email);
    const token = await auth.createCustomToken(user.uid);
    res.json({ uid: user.uid, customToken: token });
  } catch (err) {
    const message = err instanceof Error ? err.message : "Login failed";
    res.status(400).json({ error: message });
  }
});

export default router;
