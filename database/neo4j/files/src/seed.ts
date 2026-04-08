import "dotenv/config";
import { getSession } from "./neo4j.js";

async function seed() {
  const session = getSession();
  try {
    // Clear existing data
    await session.run("MATCH (n) DETACH DELETE n");

    // Create people
    await session.run(`
      CREATE (alice:Person {name: 'Alice', age: 30})
      CREATE (bob:Person {name: 'Bob', age: 25})
      CREATE (charlie:Person {name: 'Charlie', age: 35})
      CREATE (diana:Person {name: 'Diana', age: 28})
      CREATE (eve:Person {name: 'Eve', age: 32})
      CREATE (alice)-[:FOLLOWS]->(bob)
      CREATE (alice)-[:FOLLOWS]->(charlie)
      CREATE (bob)-[:FOLLOWS]->(charlie)
      CREATE (bob)-[:FOLLOWS]->(diana)
      CREATE (charlie)-[:FOLLOWS]->(eve)
      CREATE (diana)-[:FOLLOWS]->(alice)
      CREATE (eve)-[:FOLLOWS]->(alice)
    `);

    console.log("Seeded: 5 people with FOLLOWS relationships");
  } finally {
    await session.close();
  }
  process.exit(0);
}

seed();
