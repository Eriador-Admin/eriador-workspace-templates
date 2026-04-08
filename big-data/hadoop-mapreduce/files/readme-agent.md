# Agent Reference — Hadoop MapReduce

## Overview

Classic Hadoop MapReduce word count application in Java. Demonstrates the Mapper/Reducer pattern with local runner for development and Hadoop cluster submission for production.

## Tech Stack

- **Hadoop 3.3** — Distributed storage and compute framework
- **MapReduce** — Batch processing programming model
- **Java 11+** — Runtime
- **Maven** — Build tool

## Prerequisites

- Java >= 11 (OpenJDK recommended)
- Maven >= 3.8

## Project Structure

```
pom.xml                                         — Maven build config with Hadoop dependencies
src/main/java/com/example/WordCountMapper.java  — Map phase: tokenize lines into (word, 1) pairs
src/main/java/com/example/WordCountReducer.java — Reduce phase: sum counts per word
src/main/java/com/example/WordCountDriver.java  — Driver: configure and submit the MapReduce job
data/input/sample.txt                           — Sample input text file
init.sh                                         — Build the project
run.sh                                          — Run locally with Hadoop's LocalJobRunner
stop.sh                                         — Kill any running Hadoop processes
```

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Build the JAR with Maven | `bash init.sh` |
| `run.sh` | Run the MapReduce job locally | `bash run.sh` |
| `stop.sh` | Kill running Hadoop processes | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

Output is written to `data/output/`. The local runner uses Hadoop's built-in `LocalJobRunner` — no Hadoop cluster needed.

## Cluster Submission

```bash
hadoop jar target/{{ARTIFACT_ID}}-1.0.jar com.example.WordCountDriver hdfs:///input hdfs:///output
```

## Customization

- **Change Mapper logic:** Edit `WordCountMapper.java` to parse different input formats
- **Change Reducer logic:** Edit `WordCountReducer.java` for different aggregations
- **Add combiners:** Set a combiner class in `WordCountDriver.java` for map-side pre-aggregation
- **Multiple jobs:** Chain MapReduce jobs in the driver class
