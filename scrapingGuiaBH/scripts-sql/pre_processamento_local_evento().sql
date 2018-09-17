-- Function: public.pre_processamento_local_evento()

-- DROP FUNCTION public.pre_processamento_local_evento();

CREATE OR REPLACE FUNCTION public.pre_processamento_local_evento()
  RETURNS character varying AS
$BODY$
BEGIN

	UPDATE 
		stage
	SET 
		local_evento = 
			REGEXP_REPLACE(
				REGEXP_REPLACE(local_evento,
					      '<br>|b>|r>| b | s | n |<p>|p>|<div>|div|strong|\d|\W|TELEFONE|DATA',
					      ' ',
					      'ig'),
				'( ){1,}',
				' ',
				'g')			
	WHERE local_evento != '{}';
	
	IF FOUND THEN
		RETURN 'ok - pre processamento local evento';
	ELSE
		RETURN 'erro - pre processamento local evento';
	END IF;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.pre_processamento_local_evento()
  OWNER TO postgres;
