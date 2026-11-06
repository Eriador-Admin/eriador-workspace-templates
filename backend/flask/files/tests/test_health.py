import pytest
from app import create_app
from app.config import TestConfig


@pytest.fixture
def client():
    # The database binds when the app is created, so a test database must be in the config passed in.
    app = create_app(TestConfig)
    with app.test_client() as client:
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
