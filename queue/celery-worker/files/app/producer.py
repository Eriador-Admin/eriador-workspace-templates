"""Dispatch sample tasks for testing."""
from app.tasks.email import send_email
from app.tasks.report import generate_report

if __name__ == "__main__":
    result1 = send_email.delay("user@example.com", "Welcome!", "Thanks for signing up.")
    print(f"Email task dispatched: {result1.id}")

    result2 = generate_report.delay("RPT-001", "pdf")
    print(f"Report task dispatched: {result2.id}")
