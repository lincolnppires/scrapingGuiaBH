-- Function: public.pre_processamento_data_evento()

-- DROP FUNCTION public.pre_processamento_data_evento();

CREATE OR REPLACE FUNCTION public.pre_processamento_data_evento()
  RETURNS character varying AS
$BODY$
BEGIN

	UPDATE stage
		SET data_evento = 
			REGEXP_REPLACE(
				REGEXP_MATCHES(data_evento, '\d?\d/\d\d/\d\d\d\d')::varchar,
				'{|}',
				'',
				'g')
	WHERE data_evento != '{}';
	
	IF FOUND THEN
		RETURN 'ok - pre processamento data evento';
	ELSE
		RETURN 'erro - pre processamento data evento';
	END IF;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.pre_processamento_data_evento()
  OWNER TO postgres;
