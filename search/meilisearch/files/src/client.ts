import { MeiliSearch } from "meilisearch";

export const client = new MeiliSearch({
  host: process.env.MEILI_URL || "http://localhost:7700",
  apiKey: process.env.MEILI_MASTER_KEY || "masterKey123",
});
