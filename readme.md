# Scraping Guia Bh

Exemplo simples de extração, transformação e carga de um data mart a partir de dados coletados do site http://www.guiabh.com.br/.

    A modelagem dimensional no esquema estrela foi feita com o software pgModeler. 
    O coletor foi desenvolvido usando o framework Scrapy.
    Funções de limpeza e transformação em PL/pgSQL
    Carga feita com SQL
    Analise feita com SQL 

O tratamento de alguns registros foi feito de forma manual e indivídual.

Foi usado o banco PostgreSQL 9.5, módulos SQLAlchemy-1.2.11, psycopg2-2.7.5 e Scrapy 1.5.1.
