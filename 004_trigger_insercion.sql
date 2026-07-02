-- ************************************************************
-- 004-trigger-insercion.sql
--
-- Este trigger evita que se anadan mas pasajeros a la tabla,
-- el barco ya zarpo... (no vi a Rose en el registro :( )
-- ************************************************************

SET search_path TO titanic;

CREATE OR REPLACE FUNCTION insercion_pasajero()
RETURNS TRIGGER AS $$
DECLARE
total_actual INTEGER;
BEGIN
SELECT COUNT(*) INTO total_actual FROM pasajero;

IF total_actual >= 1309 THEN
RAISE EXCEPTION 'No puedes registrar más pasajeros: ¡el ya Titanic zarpó en 1912!';
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_insercion ON pasajero;
CREATE TRIGGER trigger_insercion
BEFORE INSERT ON pasajero
FOR EACH ROW
EXECUTE FUNCTION insercion_pasajero();

INSERT INTO schema_migrations (version) VALUES ('004-trigger-insercion');