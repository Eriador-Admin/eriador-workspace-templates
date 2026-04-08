import time
from app.celery_app import app


@app.task(bind=True, name="tasks.send_email")
def send_email(self, to: str, subject: str, body: str):
    """Simulate sending an email."""
    print(f"📧 Sending email to {to}: {subject}")
    time.sleep(2)
    return {"sent": True, "to": to, "subject": subject}
