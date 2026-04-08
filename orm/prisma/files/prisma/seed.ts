import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  const alice = await prisma.user.upsert({
    where: { email: "alice@example.com" },
    update: {},
    create: {
      email: "alice@example.com",
      name: "Alice",
      posts: {
        create: [
          { title: "Hello Prisma", content: "First post with Prisma ORM", published: true },
          { title: "Draft: Advanced Queries", content: "Coming soon..." },
        ],
      },
    },
  });

  const bob = await prisma.user.upsert({
    where: { email: "bob@example.com" },
    update: {},
    create: {
      email: "bob@example.com",
      name: "Bob",
      posts: {
        create: [
          { title: "Bob's First Post", content: "Hello world!", published: true },
        ],
      },
    },
  });

  console.log(`Seeded: ${alice.name}, ${bob.name}`);
}

main()
  .catch((e) => { console.error(e); process.exit(1); })
  .finally(() => prisma.$disconnect());
