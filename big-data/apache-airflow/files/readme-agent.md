# Agent Reference — Apache Airflow

## Overview

Workflow orchestration platform using Apache Airflow with Docker Compose. Includes a sample DAG that demonstrates task dependencies, BashOperator, and PythonOperator. Uses the Airflow standalone mode with SQLite for lightweight development.

## Tech Stack

- **Apache Airflow 2.9** — Workflow orchestrator
- **Python 3.9+** — DAG authoring language
- **Docker Compose** — Container orchestration for local development

## Prerequisites

- Docker and Docker Compose
- Python >= 3.9 (for local DAG development without Docker)

## Project Structure

```
docker-compose.yml              — Airflow services (webserver, scheduler, init)
dags/sample_dag.py              — Sample DAG with BashOperator and PythonOperator
dags/etl_pipeline.py            — ETL pipeline DAG skeleton
plugins/                        — Custom Airflow plugins directory
.env.example                    — Environment variable defaults
init.sh                         — Initialize Airflow database and admin user
run.sh                          — Start Airflow services
stop.sh                         — Stop Airflow services
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `AIRFLOW_PORT` | No | `8080` | Airflow webserver port |
| `AIRFLOW__CORE__FERNET_KEY` | No | *(auto-generated)* | Encryption key for connections |
| `AIRFLOW__CORE__LOAD_EXAMPLES` | No | `false` | Load example DAGs |

## Running Locally

```bash
bash init.sh
bash run.sh
```

Open `http://localhost:8080`. Login with `admin` / `admin`.

## Customization

- **Add DAGs:** Create Python files in `dags/` — Airflow auto-discovers them
- **Add operators:** Use built-in operators (BashOperator, PythonOperator, etc.) or install providers
- **Add connections:** Configure via Airflow UI → Admin → Connections
- **Add variables:** Configure via Airflow UI → Admin → Variables
- **Install providers:** Add to `requirements.txt` and rebuild the Docker image
