from fastapi import APIRouter
from app.schemas import ItemCreate, ItemResponse
import itertools

router = APIRouter()

items = []
_id_counter = itertools.count(1)

@router.get("/items", response_model=list[ItemResponse])
def list_items():
    return items

@router.post("/items", response_model=ItemResponse, status_code=201)
def create_item(item: ItemCreate):
    new = {"id": next(_id_counter), **item.model_dump()}
    items.append(new)
    return new
