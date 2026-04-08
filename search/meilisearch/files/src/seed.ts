import "dotenv/config";
import { client } from "./client.js";
import movies from "./data/movies.json" with { type: "json" };

async function seed() {
  console.log("Creating movies index...");
  const index = client.index("movies");

  await index.updateSettings({
    searchableAttributes: ["title", "genre", "director"],
    filterableAttributes: ["genre", "year"],
    sortableAttributes: ["year"],
  });

  console.log(`Indexing ${movies.length} movies...`);
  const task = await index.addDocuments(movies);
  console.log(`Enqueued task ${task.taskUid}`);

  await client.waitForTask(task.taskUid);
  console.log("Seeding complete!");
}

seed().catch((err) => {
  console.error("Seed failed:", err);
  process.exit(1);
});
