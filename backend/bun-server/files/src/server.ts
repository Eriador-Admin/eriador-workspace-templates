import { handleRequest } from "./router";
import { runMigrations } from "./db/migrations";

// Initialize database
runMigrations();

const port = parseInt(process.env.PORT || "3000", 10);

const server = Bun.serve({
  port,
  fetch: handleRequest,
});

console.log(`{{PROJECT_NAME}} running on http://localhost:${server.port}`);
