import os
from dotenv import load_dotenv
from celery import Celery

load_dotenv()

app = Celery("{{PROJECT_NAME}}")

app.conf.broker_url = os.environ.get("CELERY_BROKER_URL", "redis://localhost:6379/0")
app.conf.result_backend = os.environ.get("CELERY_RESULT_BACKEND", "redis://localhost:6379/1")
app.conf.task_serializer = "json"
app.conf.result_serializer = "json"
app.conf.accept_content = ["json"]

# Auto-discover tasks in app/tasks/
app.autodiscover_tasks(["app.tasks"])
