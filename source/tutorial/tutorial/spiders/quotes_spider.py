import sys
import scrapy
import pandas as pd
import pathlib


class QuotesSpider(scrapy.Spider):
    name = "quotes"

    start_urls = ["http://quotes.toscrape.com/page/1/",
                  "http://quotes.toscrape.com/page/2/"]

    def parse(self, response):
        for quote in response.css("div.quote"):
            yield {("text"): (quote.css("span.text::text").extract_first())}
