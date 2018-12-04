(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload :cl-py-generator))

(in-package :cl-py-generator)

(let ((code
       `(do0
	 (imports (sys
		   scrapy
		   (pd pandas)
		   pathlib))
	 )))
  (write-source "/home/martin/stage/py_scrape_leb/source/scrape" code))
