# -*- coding: utf-8 -*-
import scrapy


class GuiaBhSpiderSpider(scrapy.Spider):
    name = 'guia_bh_spider'
    allowed_domains = ['guiabh.com.br/shows']
    start_urls = ['http://guiabh.com.br/shows/']

    def parse(self, response):
        pass
