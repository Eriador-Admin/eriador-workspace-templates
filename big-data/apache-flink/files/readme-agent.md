# Agent Reference — Apache Flink

## Overview

Stateful stream processing application using Apache Flink with PyFlink. Includes a sample word count streaming job using the Table API, running in local mini-cluster mode for development.

## Tech Stack

- **Apache Flink 2.3** — Stateful stream processing framework
- **PyFlink** — Python API for Flink
- **Python 3.9–3.12** — Runtime (PyFlink 2.3 publishes wheels for CPython 3.9–3.12)
- **Java 11 or 17** — Required by Flink runtime (17 recommended)

## Prerequisites

- Python 3.9–3.12
- Java 11 or 17 (OpenJDK recommended; set `JAVA_HOME` if several JDKs are installed)
- PyFlink ships wheels for Linux x86_64 and macOS (Intel and Apple Silicon). On Linux arm64, pip builds it from source, which needs a full JDK and a C compiler
- pip

## Project Structure

```
requirements.txt              — Python dependencies (apache-flink)
src/main.py                   — Entry point: configure and run the Flink job
src/jobs/word_count.py        — Word count job: Table API SQL plus a Python table function (split_words)
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
- **Add Python functions:** Define `@udf` / `@udtf` functions and register them with `t_env.create_temporary_system_function` (see `split_words`)
- **Use DataStream API:** Switch from Table API to DataStream for lower-level control
- **Add connectors:** Install Flink connectors for Kafka, JDBC, filesystem, etc.
- **Scale:** Increase `FLINK_PARALLELISM` or deploy to a Flink cluster
