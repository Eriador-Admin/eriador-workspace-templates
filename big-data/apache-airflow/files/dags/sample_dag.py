from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator


default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}


def _print_context(**context):
    """Sample Python callable that prints the execution context."""
    print(f"Execution date: {context['ds']}")
    print(f"Task instance: {context['ti']}")
    return "Hello from PythonOperator!"


with DAG(
    dag_id="sample_dag",
    default_args=default_args,
    description="A sample DAG with Bash and Python operators",
    schedule=timedelta(days=1),
    start_date=datetime(2026, 1, 1),
    catchup=False,
    tags=["sample"],
) as dag:

    hello = BashOperator(
        task_id="say_hello",
        bash_command='echo "Hello from Airflow! Date: {{ ds }}"',
    )

    process = PythonOperator(
        task_id="process_data",
        python_callable=_print_context,
    )

    goodbye = BashOperator(
        task_id="say_goodbye",
        bash_command='echo "Pipeline complete!"',
    )

    hello >> process >> goodbye
