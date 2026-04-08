from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator


default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=5),
}


def _extract(**context):
    """Extract step: pull data from source."""
    print("Extracting data...")
    # TODO: connect to source database, API, or file system
    return {"records": 100}


def _transform(**context):
    """Transform step: clean and process data."""
    ti = context["ti"]
    extract_result = ti.xcom_pull(task_ids="extract")
    print(f"Transforming {extract_result['records']} records...")
    # TODO: apply transformations
    return {"records": extract_result["records"], "status": "transformed"}


def _load(**context):
    """Load step: write data to destination."""
    ti = context["ti"]
    transform_result = ti.xcom_pull(task_ids="transform")
    print(f"Loading {transform_result['records']} records...")
    # TODO: write to destination database or data warehouse


with DAG(
    dag_id="etl_pipeline",
    default_args=default_args,
    description="ETL pipeline skeleton: extract, transform, load",
    schedule=timedelta(hours=6),
    start_date=datetime(2026, 1, 1),
    catchup=False,
    tags=["etl"],
) as dag:

    extract = PythonOperator(task_id="extract", python_callable=_extract)
    transform = PythonOperator(task_id="transform", python_callable=_transform)
    load = PythonOperator(task_id="load", python_callable=_load)

    extract >> transform >> load
