# Scrapy settings for {{PROJECT_NAME}}

BOT_NAME = "crawler"

SPIDER_MODULES = ["crawler.spiders"]
NEWSPIDER_MODULE = "crawler.spiders"

# Obey robots.txt
ROBOTSTXT_OBEY = True

# Be polite — add delay between requests
DOWNLOAD_DELAY = 1
CONCURRENT_REQUESTS = 8
CONCURRENT_REQUESTS_PER_DOMAIN = 4

# User agent
USER_AGENT = "{{PROJECT_NAME}} (+http://www.example.com)"

# Pipelines
ITEM_PIPELINES = {
    "crawler.pipelines.CleanTextPipeline": 100,
    "crawler.pipelines.DuplicateFilterPipeline": 200,
}

# Feeds — default output format
FEEDS = {
    "output/%(name)s_%(time)s.json": {
        "format": "json",
        "encoding": "utf-8",
        "indent": 2,
    },
}

# Logging
LOG_LEVEL = "INFO"

# Request fingerprinter
REQUEST_FINGERPRINTER_IMPLEMENTATION = "2.7"
TWISTED_REACTOR = "twisted.internet.asyncioreactor.AsyncioSelectorReactor"
FEED_EXPORT_ENCODING = "utf-8"
