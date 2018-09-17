# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

from sqlalchemy.orm import sessionmaker
from scrapingGuiaBH.models import db_connect, create_table, Itens

class ScrapingguiabhPipeline(object):

    def __init__(self):
        """
            Inicializa a conexao e sessionmaker
            Cria a tabela stage
        """
        engine = db_connect()
        create_table(engine)
        self.Session = sessionmaker(bind=engine)

    def process_item(self, item, spider):

        session = self.Session()
        stage = Itens(**item)

        try:
            session.add(stage)
            session.commit()
        except:
            session.rollback()
            raise
        finally:
            session.close()

        return item
