# {{PROJECT_NAME}}

A web scraping project built with [Scrapy](https://scrapy.org/) — the most popular Python framework for extracting data from websites, with built-in support for crawling, pipelines, and data export.

## Getting Started

```bash
bash init.sh    # create venv, install dependencies
bash run.sh     # run the example spider
bash stop.sh    # stop any running spiders
```

## Prerequisites

- Python 3.10+

## Project Structure

```
scrapy.cfg                      # Scrapy deploy config
crawler/
  __init__.py
  settings.py                   # Scrapy settings (user-agent, pipelines, etc.)
  items.py                      # Data models (Scrapy Items)
  middlewares.py                 # Download/spider middlewares
  pipelines.py                  # Item pipelines (clean, validate, store)
  spiders/
    __init__.py
    example_spider.py           # Example spider (quotes.toscrape.com)
    pagination_spider.py        # Spider with pagination support
output/                         # Scraped data output directory
```

## Running Spiders

```bash
# Run a specific spider
scrapy crawl example

# Run with JSON output
scrapy crawl example -O output/results.json

# Run with CSV output
scrapy crawl example -O output/results.csv

# Interactive shell (test selectors)
scrapy shell "https://quotes.toscrape.com"

# List available spiders
scrapy list
```

## Selectors

```python
# CSS selectors
response.css("h1::text").get()
response.css("div.content a::attr(href)").getall()

# XPath selectors
response.xpath("//h1/text()").get()
response.xpath("//a/@href").getall()
```

## Useful Commands

```bash
scrapy list              # List spiders
scrapy crawl <name>      # Run a spider
scrapy shell <url>       # Interactive selector testing
scrapy view <url>        # Open page in browser as Scrapy sees it
scrapy genspider <name> <domain>  # Generate new spider
```
