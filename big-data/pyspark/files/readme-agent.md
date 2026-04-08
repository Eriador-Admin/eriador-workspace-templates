# Agent Reference — PySpark

## Overview

Distributed data processing application using Apache Spark with PySpark bindings. Includes a sample ETL job, configuration management, and local Spark session setup. Runs locally in `local[*]` mode or connects to a Spark cluster.

## Tech Stack

- **Apache Spark 3.5** — Distributed compute engine
- **PySpark** — Python API for Spark
- **Python 3.9+** — Runtime
- **Java 11+** — Required by Spark runtime

## Prerequisites

- Python >= 3.9
- Java >= 11 (OpenJDK recommended)
- pip (included with Python)

## Project Structure

```
requirements.txt        — Python dependencies (pyspark)
src/main.py             — Entry point: creates SparkSession and runs the ETL job
src/jobs/sample_etl.py  — Sample ETL job: read, transform, write
src/utils/spark.py      — SparkSession factory with configuration
data/input/sample.csv   — Sample input data
data/output/            — Output directory (gitignored)
.env.example            — Environment variable defaults
init.sh                 — Create venv, install dependencies
run.sh                  — Run the Spark application
stop.sh                 — Stop running Spark processes
Dockerfile              — Container with Spark and Python
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `SPARK_MASTER` | No | `local[*]` | Spark master URL |
| `SPARK_APP_NAME` | No | `{{APP_NAME}}` | Application name in Spark UI |
| `INPUT_PATH` | No | `data/input/sample.csv` | Path to input data |
| `OUTPUT_PATH` | No | `data/output/result` | Path for output data |

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Create Python venv, install dependencies, copy `.env.example` | `bash init.sh` |
| `run.sh` | Run the PySpark application | `bash run.sh` |
| `stop.sh` | Kill any running Spark driver processes | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

Spark runs in `local[*]` mode by default (uses all CPU cores). Output is written to `data/output/result/`.

## Docker Deployment

```bash
docker build -t pyspark-app .
docker run --rm -v $(pwd)/data:/app/data pyspark-app
```

## Cluster Deployment

Set `SPARK_MASTER` to your cluster master:

```bash
export SPARK_MASTER=spark://master:7077
bash run.sh
```

Or use `spark-submit`:

```bash
spark-submit --master spark://master:7077 src/main.py
```

## Customization

- **Add jobs:** Create new files in `src/jobs/` and call them from `src/main.py`
- **Change data source:** Update `INPUT_PATH` to read from HDFS, S3, or a database
- **Add dependencies:** Add to `requirements.txt` and re-run `bash init.sh`
- **Tune Spark:** Configure executor memory, cores, and partitions in `src/utils/spark.py`
