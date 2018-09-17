-- Function: public.pre_processamento_local_venda()

-- DROP FUNCTION public.pre_processamento_local_venda();

CREATE OR REPLACE FUNCTION public.pre_processamento_local_venda()
  RETURNS character varying AS
$BODY$
BEGIN

	UPDATE 
		stage
	SET 
		local_venda = 
			REGEXP_REPLACE(
				REGEXP_REPLACE(local_venda,
					      '.*?VENDA|\n|<.?div>|"|}|<.?p>|<br>|<.?strong>|S:|{|INGRESSO|href|header| e |retirada|de|do|para|online|.*os eventos|^ *|a http|\W',
					      ' ',
					      'ig'),
				'( ){1,}',
				' ',
				'g')			
	WHERE local_venda != '{}';
	
	IF FOUND THEN
		RETURN 'ok - pre processamento local venda';
	ELSE
		RETURN 'erro - pre processamento local venda';
	END IF;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.pre_processamento_local_venda()
  OWNER TO postgres;
