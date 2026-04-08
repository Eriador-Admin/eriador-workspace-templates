from rest_framework.decorators import api_view
from rest_framework.response import Response


@api_view(["GET"])
def hello(request):
    return Response({"message": "Hello from Django!"})


@api_view(["GET"])
def items(request):
    sample_items = [
        {"id": 1, "name": "Item One", "done": False},
        {"id": 2, "name": "Item Two", "done": True},
        {"id": 3, "name": "Item Three", "done": False},
    ]
    return Response(sample_items)
