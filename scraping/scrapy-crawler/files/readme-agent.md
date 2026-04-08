# Agent Instructions — {{PROJECT_NAME}}

This is a web scraping project using the Scrapy framework.

## Tech Stack
- **Language**: Python 3.10+
- **Framework**: Scrapy 2.11+

## Key Conventions
- Project config in `scrapy.cfg`, settings in `crawler/settings.py`
- Spiders in `crawler/spiders/` — each spider is a class extending `scrapy.Spider`
- Items in `crawler/items.py` — define data shape with `scrapy.Item` + `scrapy.Field()`
- Pipelines in `crawler/pipelines.py` — process/clean/store items
- Use CSS selectors (`response.css()`) or XPath (`response.xpath()`)
- `.get()` for single result, `.getall()` for list
- Yield items from `parse()` to send through pipelines
- Yield `scrapy.Request()` to follow links / paginate
- Respect robots.txt — `ROBOTSTXT_OBEY = True` in settings
- Set a descriptive `USER_AGENT` and reasonable `DOWNLOAD_DELAY`
- Output to JSON/CSV with `-O output/file.json` flag
- Use `scrapy shell <url>` to test selectors interactively
