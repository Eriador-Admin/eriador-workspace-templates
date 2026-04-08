import "dotenv/config";
import express from "express";
import { getSession, driver } from "./neo4j.js";

const app = express();
const PORT = parseInt(process.env.PORT || "3000", 10);

app.use(express.json());

app.get("/health", (_req, res) => res.json({ status: "ok" }));

app.get("/people", async (_req, res) => {
  const session = getSession();
  try {
    const result = await session.run("MATCH (p:Person) RETURN p ORDER BY p.name");
    const people = result.records.map((r) => r.get("p").properties);
    res.json(people);
  } finally {
    await session.close();
  }
});

app.post("/people", async (req, res) => {
  const { name, age } = req.body;
  if (!name) return res.status(400).json({ error: "name is required" });

  const session = getSession();
  try {
    const result = await session.run(
      "CREATE (p:Person {name: $name, age: $age}) RETURN p",
      { name, age: age || null }
    );
    res.status(201).json(result.records[0].get("p").properties);
  } finally {
    await session.close();
  }
});

app.post("/people/:name/follows/:target", async (req, res) => {
  const session = getSession();
  try {
    const result = await session.run(
      `MATCH (a:Person {name: $name}), (b:Person {name: $target})
       MERGE (a)-[r:FOLLOWS]->(b)
       RETURN a.name AS from, b.name AS to`,
      { name: req.params.name, target: req.params.target }
    );
    if (result.records.length === 0) {
      return res.status(404).json({ error: "One or both people not found" });
    }
    res.json({ from: result.records[0].get("from"), to: result.records[0].get("to") });
  } finally {
    await session.close();
  }
});

app.get("/people/:name/followers", async (req, res) => {
  const session = getSession();
  try {
    const result = await session.run(
      "MATCH (follower:Person)-[:FOLLOWS]->(p:Person {name: $name}) RETURN follower",
      { name: req.params.name }
    );
    const followers = result.records.map((r) => r.get("follower").properties);
    res.json(followers);
  } finally {
    await session.close();
  }
});

app.get("/people/:name/recommendations", async (req, res) => {
  const session = getSession();
  try {
    const result = await session.run(
      `MATCH (me:Person {name: $name})-[:FOLLOWS]->(friend)-[:FOLLOWS]->(suggestion)
       WHERE suggestion <> me AND NOT (me)-[:FOLLOWS]->(suggestion)
       RETURN DISTINCT suggestion, count(friend) AS mutualFriends
       ORDER BY mutualFriends DESC LIMIT 5`,
      { name: req.params.name }
    );
    const recs = result.records.map((r) => ({
      ...r.get("suggestion").properties,
      mutualFriends: r.get("mutualFriends").toNumber(),
    }));
    res.json(recs);
  } finally {
    await session.close();
  }
});

process.on("SIGINT", async () => { await driver.close(); process.exit(0); });

app.listen(PORT, () => {
  console.log(`Neo4j API: http://localhost:${PORT}`);
  console.log(`Neo4j Browser: http://localhost:7474`);
});
