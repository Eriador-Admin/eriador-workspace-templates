from itemadapter import ItemAdapter


class CleanTextPipeline:
    """Strip whitespace from all string fields."""

    def process_item(self, item, spider):
        adapter = ItemAdapter(item)
        for field_name in adapter.field_names():
            value = adapter.get(field_name)
            if isinstance(value, str):
                adapter[field_name] = value.strip()
        return item


class DuplicateFilterPipeline:
    """Drop duplicate items based on a key field."""

    def __init__(self):
        self.seen = set()

    def process_item(self, item, spider):
        adapter = ItemAdapter(item)
        # Use 'text' or 'url' as dedupe key
        key = adapter.get("text") or adapter.get("url") or ""
        if key in self.seen:
            from scrapy.exceptions import DropItem
            raise DropItem(f"Duplicate item: {key[:50]}")
        self.seen.add(key)
        return item
