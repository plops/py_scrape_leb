(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload :cl-py-generator))

(in-package :cl-py-generator)

;; cd ~/stage/py_scrape_leb/source ; scrapy startproject tutorial
;; cd ~/stage/py_scrape_leb/source/tutorial ; scrapy crawl quotes

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
		      ("yield scrapy.Request" :url url :callback
					      self.parse)))
		(def parse (self response)
		  (setf page (aref (response.url.split (string "/"))
				   -2)
			fn (dot (string "/dev/shm/quotes-{}.html")
				(format page))
			f (open fn "wb"))
		  (f.write response.body)
		  (f.close)
		  (self.log (dot (string "saved file {}.")
				 (format fn)))))
	 )))
  (write-source "/home/martin/stage/py_scrape_leb/source/tutorial/spiders/quotes_spider" code))
