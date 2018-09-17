-- Function: public.pre_processamento_tipo_ingresso()

-- DROP FUNCTION public.pre_processamento_tipo_ingresso();

CREATE OR REPLACE FUNCTION public.pre_processamento_tipo_ingresso()
  RETURNS character varying AS
$BODY$
BEGIN

	UPDATE 
		stage
	SET 
		tipo_ingresso = 
			REGEXP_REPLACE(
				REGEXP_REPLACE(local_venda,
					      '.*?INGRESSO|\n|<.?div>|"|}|<.?p>|<br>|<.?strong>|S:|{|VENDA|href|header| e |retirada|de|do|para|online|.*os eventos|^ *|a http|\W',
					      ' ',
					      'ig'),
				'( ){1,}',
				' ',
				'g')			
	WHERE tipo_ingresso != '{}';
	
	IF FOUND THEN
		RETURN 'ok - pre processamento tipo ingresso';
	ELSE
		RETURN 'erro - pre processamento tipo ingresso';
	END IF;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.pre_processamento_tipo_ingresso()
  OWNER TO postgres;
