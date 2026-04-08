import "dotenv/config";
import { db } from "./db.js";
import { users, posts } from "./schema.js";

async function seed() {
  const [alice] = await db.insert(users).values({ email: "alice@example.com", name: "Alice" }).returning();
  const [bob] = await db.insert(users).values({ email: "bob@example.com", name: "Bob" }).returning();

  await db.insert(posts).values([
    { title: "Hello Drizzle", content: "First post with Drizzle ORM", published: true, authorId: alice.id },
    { title: "Draft Post", content: "Coming soon...", authorId: alice.id },
    { title: "Bob's Post", content: "Hello world!", published: true, authorId: bob.id },
  ]);

  console.log("Seeded: Alice, Bob, 3 posts");
  process.exit(0);
}

seed();
