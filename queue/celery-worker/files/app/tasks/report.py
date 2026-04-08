import time
from app.celery_app import app


@app.task(bind=True, name="tasks.generate_report")
def generate_report(self, report_id: str, fmt: str = "pdf"):
    """Simulate generating a report with progress."""
    print(f"📊 Generating {fmt} report: {report_id}")
    for i in range(1, 5):
        time.sleep(1)
        self.update_state(state="PROGRESS", meta={"percent": i * 25})
    return {"report_id": report_id, "format": fmt, "status": "complete"}
