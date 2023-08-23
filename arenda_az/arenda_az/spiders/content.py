import scrapy
from scrapy_splash import SplashRequest


class MySpider(scrapy.Spider):
    name = 'content'
    start_urls = [
        'https://arenda.az/kiraye-gunluk-3-otaqli-yeni-tikili-nesimi-rayonu-28-may-metrosu-suleyman-rustem-kucesi-3']

    def start_requests(self):
        for url in self.start_urls:
            yield SplashRequest(url, self.parse, args={'wait': 2})

    def parse(self, response):
        yield {
            'name': response.css('div.new_elan_user_info p:first-child::text').getall(),
            'phone':response.css('div.new_elan_user_info p.elan_in_tel_box a.elan_in_tel::text').getall()
        }
