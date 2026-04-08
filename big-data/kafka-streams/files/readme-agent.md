# Agent Reference — Kafka Streams

## Overview

Real-time stream processing application using Kafka Streams. Reads from an input topic, applies a word count transformation using a KTable, and writes results to an output topic. Runs as a standalone Java process.

## Tech Stack

- **Apache Kafka 3.7** — Distributed event streaming platform
- **Kafka Streams** — Client library for stream processing
- **Java 11+** — Runtime
- **Maven** — Build tool

## Prerequisites

- Java >= 11
- Maven >= 3.8
- Running Kafka broker (or use the included docker-compose.yml)

## Project Structure

```
pom.xml                                              — Maven config with kafka-streams dependency
src/main/java/com/example/StreamProcessor.java       — Main class: topology definition and stream start
src/main/java/com/example/WordCountTopology.java     — Stream topology: input → flatMap → groupBy → count → output
docker-compose.yml                                   — Local Kafka + Zookeeper for development
.env.example                                         — Environment variable defaults
init.sh                                              — Build the project
run.sh                                               — Run the stream processor
stop.sh                                              — Stop the stream processor
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `BOOTSTRAP_SERVERS` | No | `localhost:9092` | Kafka broker addresses |
| `INPUT_TOPIC` | No | `input-text` | Topic to consume from |
| `OUTPUT_TOPIC` | No | `word-counts` | Topic to produce to |
| `APPLICATION_ID` | No | `{{ARTIFACT_ID}}` | Kafka Streams application ID |

## Running Locally

Start Kafka:
```bash
docker compose up -d
```

Build and run:
```bash
bash init.sh
bash run.sh
```

Produce test messages:
```bash
echo "hello world hello" | docker compose exec -T kafka kafka-console-producer --bootstrap-server localhost:9092 --topic input-text
```

Consume results:
```bash
docker compose exec kafka kafka-console-consumer --bootstrap-server localhost:9092 --topic word-counts --from-beginning --property print.key=true
```

## Customization

- **Change topology:** Edit `WordCountTopology.java` to define different transformations
- **Add state stores:** Use `Materialized.as("store-name")` for queryable state
- **Add Serde:** Implement custom serializers for complex value types
- **Scale out:** Run multiple instances with the same `APPLICATION_ID` for parallel processing
