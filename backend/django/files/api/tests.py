from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase


class HealthCheckTests(APITestCase):
    def test_health_is_public(self):
        response = self.client.get(reverse("health-check"))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.json(), {"status": "ok"})


class ItemTests(APITestCase):
    def setUp(self):
        self.user = get_user_model().objects.create_user(username="tester", password="test-password")
        self.client.force_authenticate(self.user)

    def test_items_require_authentication(self):
        self.client.force_authenticate(None)
        response = self.client.get(reverse("item-list-create"))
        self.assertIn(response.status_code, (status.HTTP_401_UNAUTHORIZED, status.HTTP_403_FORBIDDEN))

    def test_create_list_update_delete(self):
        created = self.client.post(reverse("item-list-create"), {"name": "First"}, format="json")
        self.assertEqual(created.status_code, status.HTTP_201_CREATED)
        item_id = created.json()["id"]

        listed = self.client.get(reverse("item-list-create"))
        self.assertEqual([item["name"] for item in listed.json()], ["First"])

        detail = reverse("item-detail", args=[item_id])
        updated = self.client.patch(detail, {"description": "Changed"}, format="json")
        self.assertEqual(updated.json()["description"], "Changed")

        self.assertEqual(self.client.delete(detail).status_code, status.HTTP_204_NO_CONTENT)
        self.assertEqual(self.client.get(detail).status_code, status.HTTP_404_NOT_FOUND)
