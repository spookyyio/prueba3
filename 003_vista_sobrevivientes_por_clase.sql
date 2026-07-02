-- ************************************************************
-- 003-vista-sobrevivientes-por-clase.sql
--
-- Se crea una vista que devuelve el total de pasajeros por clase
-- y cuantos de ellos sobrevivieron.
-- ************************************************************

SET search_path TO titanic;

CREATE OR REPLACE VIEW vista_sobrevivientes_por_clase AS SELECT c.descripcion_clase,
COUNT(p.passengerid) AS total_pasajeros,
COUNT(p.passengerid) FILTER (WHERE p.sobrevivio = TRUE) AS total_sobrevivientes
FROM clase c
JOIN pasajero p ON c.clase = p.clase
GROUP BY c.clase, c.descripcion_clase;

INSERT INTO schema_migrations (version) VALUES ('003-vista-sobrevivientes-por-clase');