from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import generics

from .models import Item
from .serializers import ItemSerializer


@api_view(["GET"])
def health_check(request):
    return Response({"status": "ok"})


class ItemListCreate(generics.ListCreateAPIView):
    queryset = Item.objects.all()
    serializer_class = ItemSerializer


class ItemDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Item.objects.all()
    serializer_class = ItemSerializer
