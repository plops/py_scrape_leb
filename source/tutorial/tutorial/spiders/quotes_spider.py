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
        page=response.url.split("/")[-2]
        fn="/dev/shm/quotes-{}.html".format(page)
        f=open(fn, "wb")

        f.write(response.body)
        f.close()
        self.log("saved file {}.".format(fn))

