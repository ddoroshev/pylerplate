from typing import List

from pydantic import BaseModel

__all__ = ("list_items", "read_item")


class Item(BaseModel):
    item_id: int


async def list_items() -> List[Item]:
    return [Item(item_id=1), Item(item_id=2)]


async def read_item(item_id: int) -> Item:
    return Item(item_id=item_id)


async def buggy_view_1() -> Item:
    return Item(item_id="a")  # type: ignore


async def buggy_view_2() -> Item:
    return Item(item_id=1 / 0)  # type: ignore
