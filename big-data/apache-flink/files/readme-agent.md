# Agent Reference — Apache Flink

## Overview

Stateful stream processing application using Apache Flink with PyFlink. Includes a sample word count streaming job using the Table API, running in local mini-cluster mode for development.

## Tech Stack

- **Apache Flink 1.19** — Stateful stream processing framework
- **PyFlink** — Python API for Flink
- **Python 3.9+** — Runtime
- **Java 11+** — Required by Flink runtime

## Prerequisites

- Python >= 3.9
- Java >= 11 (OpenJDK recommended)
- pip

## Project Structure

```
requirements.txt              — Python dependencies (apache-flink)
src/main.py                   — Entry point: configure and run the Flink job
src/jobs/word_count.py        — Word count job using the Table API
data/input/sample.txt         — Sample input data
data/output/                  — Output directory (gitignored)
.env.example                  — Environment variable defaults
init.sh                       — Create venv, install dependencies
run.sh                        — Run the Flink job locally
stop.sh                       — Stop Flink processes
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `FLINK_PARALLELISM` | No | `1` | Job parallelism level |
| `INPUT_PATH` | No | `data/input/sample.txt` | Path to input data |
| `OUTPUT_PATH` | No | `data/output/result.csv` | Path for output data |

## Running Locally

```bash
bash init.sh
bash run.sh
```

Flink runs in local mini-cluster mode (no external cluster needed). Output is written to `data/output/`.

## Customization

- **Change job logic:** Edit `src/jobs/word_count.py` or create new jobs
- **Use DataStream API:** Switch from Table API to DataStream for lower-level control
- **Add connectors:** Install Flink connectors for Kafka, JDBC, filesystem, etc.
- **Scale:** Increase `FLINK_PARALLELISM` or deploy to a Flink cluster
