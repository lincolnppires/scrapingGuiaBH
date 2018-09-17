--CARGA DAS DIMENSÕES 

INSERT INTO d_categoria_evento(descricao) (SELECT DISTINCT(categoria) FROM stage);
INSERT INTO d_evento(descricao) (SELECT DISTINCT(COALESCE(descricao_evento,url)) FROM stage);
INSERT INTO d_local_evento(endereco) (SELECT DISTINCT(local_evento) FROM stage);
INSERT INTO d_local_venda(local) (SELECT DISTINCT(local_venda) FROM stage);
INSERT INTO d_tipo_ingresso(descricao) (SELECT DISTINCT(tipo_ingresso) FROM stage);
INSERT INTO d_tempo(data, dia, mes, ano) ( 
	SELECT 
		DISTINCT(data_evento::date), 
		SPLIT_PART( data_evento, '/', 1)::smallint dia,
		SPLIT_PART( data_evento, '/', 2)::smallint mes,
		SPLIT_PART( data_evento, '/', 3)::smallint ano
	FROM stage);

--CARGA DA TABELA FATO
UPDATE stage SET  valor_ingresso = 'R$0' WHERE valor_ingresso = '{}';

INSERT INTO f_valor_ingresso (id_d_categoria_evento, id_d_evento, id_d_local_evento, id_d_local_venda,
				id_d_tipo_ingresso, id_d_tempo, valor_ingresso)
	   (
		SELECT dcv.id_d_categoria_evento, de.id_d_evento, dle.id_d_local_evento, dlv.id_d_local_venda,
				dti.id_d_tipo_ingresso, dt.id_d_tempo, 
				(SPLIT_PART(stage.valor_ingresso, '$', 2))::numeric
			FROM stage stage JOIN d_categoria_evento dcv  ON stage.categoria = dcv.descricao
					 JOIN d_evento de ON stage.descricao_evento = de.descricao
					 JOIN d_local_evento dle ON stage.local_evento = dle.endereco
					 JOIN d_local_venda dlv ON stage.local_venda = dlv.local
					 JOIN d_tipo_ingresso dti ON stage.tipo_ingresso = dti.descricao
					 JOIN d_tempo dt ON stage.data_evento::date = dt.data
	   );

--fim
