import scrapy
from crawler.items import PageItem


class PaginationSpider(scrapy.Spider):
    """Spider demonstrating pagination with page number URLs."""

    name = "pagination"
    allowed_domains = ["quotes.toscrape.com"]

    def start_requests(self):
        for page in range(1, 4):  # First 3 pages
            url = f"https://quotes.toscrape.com/page/{page}/"
            yield scrapy.Request(url, callback=self.parse, meta={"page": page})

    def parse(self, response):
        page = response.meta.get("page", 1)

        for quote in response.css("div.quote"):
            item = PageItem()
            item["title"] = quote.css("small.author::text").get()
            item["url"] = response.url
            item["content"] = quote.css("span.text::text").get()
            yield item

        self.logger.info(f"Scraped page {page}: {response.url}")
