-- Function: public.pre_processamento_valor_ingresso()

-- DROP FUNCTION public.pre_processamento_valor_ingresso();

CREATE OR REPLACE FUNCTION public.pre_processamento_valor_ingresso()
  RETURNS character varying AS
$BODY$
BEGIN

	UPDATE stage
		SET valor_ingresso = 
			REGEXP_REPLACE( 
				REGEXP_MATCHES(valor_ingresso,'R\$.*?[<, ]', 'g')::varchar,
				'{|<|}|"|,|"{}"',
				'',
				'g')		
	;
	
	IF FOUND THEN
		RETURN 'ok - pre processamento valor ingresso';
	ELSE
		RETURN 'erro - pre processamento valor evento';
	END IF;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.pre_processamento_valor_ingresso()
  OWNER TO postgres;
