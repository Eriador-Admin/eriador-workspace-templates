import "dotenv/config";
import express from "express";
import payload from "payload";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

async function start() {
  await payload.init({
    secret: process.env.PAYLOAD_SECRET || "change-me",
    express: app,
  });

  app.listen(PORT, () => {
    console.log(`Payload CMS: http://localhost:${PORT}`);
    console.log(`Admin Panel: http://localhost:${PORT}/admin`);
  });
}

start();
