import sys
import scrapy
import pandas as pd
import pathlib

class QuotesSpider(scrapy.Spider):
    name="quotes"

    def start_requests(self):
        urls=["http://quotes.toscrape.com/page/1/", "http://quotes.toscrape.com/page/2/"]

        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)


    def parse(self, response):
        for quote in response.css("div.quote"):
            yield {("text"):(quote.css("span.text::text").extract_first())}

        for href in response.css("li.next a::attr(href)"):
            yield response.follow(href, callback=self.parse)



