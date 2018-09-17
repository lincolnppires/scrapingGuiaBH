# -*- coding: utf-8 -*-
import scrapy


class Guia_bh_spider(scrapy.Spider):
    name = 'guia_bh_spider'
    start_urls = ['http://guiabh.com.br/shows/']

    def parse(self, response):

        yield {
            "url": response.url,
            "categoria": response.url.split("/")[3],
            "descricao_evento": response.css('div.col-md-7>h1::text').extract_first(),
            "local_evento": response.xpath('//div[@class=\'col-md-12\']').re(
                r'(?:(?i)ENDEREÇO|LOCAL[\w,\W,\s,\d]*?[^</,<p>,\w])(?:[\w,\W,\s,\d]*?[\n,/b>])([\w,\W,\s,\d]*?</)'),

            "local_venda": response.xpath('//div[@class=\'col-md-12\']').re(r'VENDA|INGRESSO[\w,\W]*'),
            "tipo_ingresso": response.xpath('//div[@class=\'col-md-12\']').re(r'INGRESSO[\w,\W]*'),
            "valor_ingresso": response.xpath('//div[@class=\'col-md-12\']').re(r'INGRESSO[\w,\W]*'),
            "data_evento": response.xpath('//div[@class=\'col-md-7\']/span[@class=\'data\']').extract_first(),
        }

        proximos_links = response.xpath('//a/@href').re(r'(?:/shows/)(.*)')
        for proximo in proximos_links:
            if proximo is not None:
                proximo = response.urljoin(proximo)
                yield scrapy.Request(proximo, callback=self.parse)

