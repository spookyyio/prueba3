-- ************************************************************
-- 002-marcar-tripulacion.sql
--
-- Hay registros de tripulacion mezclados con pasajeros,
-- la columna es_tripulacion se anadira para diferenciar
-- tripulacion de pasajeros. (Valor default FALSE, todos los registros
-- actuales son pasajeros)
-- ************************************************************

SET search_path TO titanic;

ALTER TABLE pasajeros ADD COLUMN IF NOT EXISTS es_tripulacion BOOLEAN DEFAULT FALSE NOT NULL;

INSERT INTO schema_migrations (version) VALUES ('002-marcar-tripulacion');