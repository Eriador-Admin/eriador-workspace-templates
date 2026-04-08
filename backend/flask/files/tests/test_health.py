import pytest
from app import create_app


@pytest.fixture
def client():
    app = create_app()
    app.config["TESTING"] = True
    app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///:memory:"
    with app.test_client() as client:
        with app.app_context():
            from app import db
            db.create_all()
        yield client


def test_health(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json()["status"] == "ok"


def test_create_item(client):
    response = client.post("/api/items", json={"name": "Test Item"})
    assert response.status_code == 201
    assert response.get_json()["name"] == "Test Item"


def test_list_items(client):
    client.post("/api/items", json={"name": "Item 1"})
    response = client.get("/api/items")
    assert response.status_code == 200
    assert len(response.get_json()) == 1
