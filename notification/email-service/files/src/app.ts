import "dotenv/config";
import express from "express";
import { sendEmail } from "./mailer.js";
import { welcomeEmail } from "./templates/welcome.js";
import { resetPasswordEmail } from "./templates/reset-password.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(express.json());

app.get("/health", (_req, res) => {
  res.json({ status: "ok" });
});

app.post("/send", async (req, res) => {
  const { to, subject, html } = req.body;
  if (!to || !subject || !html) {
    return res.status(400).json({ error: "to, subject, and html are required" });
  }
  const info = await sendEmail({ to, subject, html });
  res.json({ messageId: info.messageId });
});

app.post("/send/welcome", async (req, res) => {
  const { to, name } = req.body;
  if (!to || !name) {
    return res.status(400).json({ error: "to and name are required" });
  }
  const info = await sendEmail({
    to,
    subject: "Welcome!",
    html: welcomeEmail(name),
  });
  res.json({ messageId: info.messageId });
});

app.post("/send/reset-password", async (req, res) => {
  const { to, resetUrl } = req.body;
  if (!to || !resetUrl) {
    return res.status(400).json({ error: "to and resetUrl are required" });
  }
  const info = await sendEmail({
    to,
    subject: "Reset Your Password",
    html: resetPasswordEmail(resetUrl),
  });
  res.json({ messageId: info.messageId });
});

app.listen(PORT, () => {
  console.log(`Email API: http://localhost:${PORT}`);
  console.log(`MailHog UI: http://localhost:8025`);
});
