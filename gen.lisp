(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload :cl-py-generator))

(in-package :cl-py-generator)
;; https://doc.scrapy.org/en/latest/intro/tutorial.html
;; cd ~/stage/py_scrape_leb/source ; scrapy startproject tutorial
;; cd ~/stage/py_scrape_leb/source/tutorial ; scrapy crawl quotes
;; use selectorgadget.com bookmarklet to find selectors
;; learn xpath, select link that contains text "next page"
(let ((code
       `(do0
	 (imports (sys
		   scrapy
		   (pd pandas)
		   pathlib))
	 (class QuotesSpider (scrapy.Spider)
		(setf name (string "quotes"))
		(def start_requests (self)
		 (setf urls (list  (string "http://quotes.toscrape.com/page/1/")
				   (string "http://quotes.toscrape.com/page/2/")))
		 (for (url urls)
		      (yield (scrapy.Request :url url :callback
					       self.parse))))
		(def parse (self response)
		  (for (quote (response.css (string "div.quote")))
		       (yield
			(dict ((string text) (dot (quote.css (string
							      "span.text::text"))
						  (extract_first))))))
		  (for (href (response.css (string "li.next a::attr(href)")))
		      (yield (response.follow href :callback self.parse)))))
	 )))
  (write-source "/home/martin/stage/py_scrape_leb/source/tutorial/tutorial/spiders/quotes_spider" code))
