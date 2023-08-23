import scrapy
from scrapy_splash import SplashRequest

class LinksSpider(scrapy.Spider):
    name = "links"
    allowed_domains = ["arenda.az"]
    start_urls = [
        "https://arenda.az/filtirli-axtaris/1/?home_search=1&lang=1&site=1&home_s=1&price_min=&price_max=&otaq_min=0&otaq_max=0&sahe_min=&sahe_max=&mertebe_min=0&mertebe_max=0&y_mertebe_min=0&y_mertebe_max=0&axtar="]

    def start_requests(self):
        for url in self.start_urls:
            yield SplashRequest(url, self.parse, args={'wait': 2})

    def parse(self, response):
        yield {
            'link': response.css('li.new_elan_box a::attr(href)').getall(),
        }
