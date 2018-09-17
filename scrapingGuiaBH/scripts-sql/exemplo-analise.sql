--Visão dimensional da quantidade de eventos por ano e mês. Com a consulta abaixo, é possível
--responder a quantidade de eventos que aconteceram no ano e mês, em determinado ano, em qual
--época do ano ocorre mais eventos e o total de eventos na base de dados.

SELECT d.ano, d.mes, COUNT(*) quantidade_eventos
	FROM f_valor_ingresso f
		JOIN d_tempo d ON f.id_d_tempo = d.id_d_tempo
GROUP BY
	CUBE(ano, mes)
ORDER BY ano, mes

--Visão dimensional da média dos valores dos ingressos por ano e mês.

SELECT d.ano, d.mes, AVG(valor_ingresso) media_valor_ingresso
	FROM f_valor_ingresso f
		JOIN d_tempo d ON f.id_d_tempo = d.id_d_tempo
GROUP BY
	CUBE(ano, mes)
ORDER BY ano, mes
