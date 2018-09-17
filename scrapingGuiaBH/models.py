from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.engine.url import URL

import scrapingGuiaBH.settings

DeclarativeBase = declarative_base()

def db_connect():
    """
    Executa a conexao com o bando de dados usando as configuracoes settings.py
    Retorna uma instancia de sqlalchemy

    """
    return create_engine(URL(**scrapingGuiaBH.settings.DATABASE))

def create_table(engine):
    DeclarativeBase.metadata.create_all(engine)

class Itens(DeclarativeBase):

    __tablename__ = "stage"
    id = Column('id', Integer, primary_key=True, autoincrement=True)
    url = Column('url', String)
    categoria = Column('categoria', String)
    descricao_evento = Column('descricao_evento', String)
    local_evento = Column('local_evento', String)
    local_venda = Column('local_venda', String)
    tipo_ingresso = Column('tipo_ingresso', String)
    valor_ingresso = Column('valor_ingresso', String)
    data_evento = Column('data_evento', String)