import { Database } from "bun:sqlite";

export const db = new Database("data.sqlite", { create: true });

// Enable WAL mode for better concurrent read performance
db.run("PRAGMA journal_mode = WAL");
