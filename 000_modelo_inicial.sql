-- ************************************************************
-- 000-modelo-inicial.sql
--
-- Migracion inicial: schema, tabla de control y el modelo del
-- Titanic normalizado en 3FN. Sin datos (entran en 001).
-- Lo unico multivaluado del dataset es la cabina: se extrae a
-- su tabla + puente. El resto son hechos por pasajero.
-- ¡ESTA MIGRACIÓN NO SE TOCA!
-- ************************************************************

CREATE SCHEMA IF NOT EXISTS titanic;
SET search_path TO titanic;

CREATE TABLE IF NOT EXISTS schema_migrations (
    version    TEXT PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT now()
);

CREATE TABLE IF NOT EXISTS clase (
    clase             INTEGER PRIMARY KEY,
    descripcion_clase TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS puerto (
    embarque      INTEGER PRIMARY KEY,
    nombre_puerto TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS cabina (
    cabina TEXT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS pasajero (
    passengerid     INTEGER PRIMARY KEY,
    nombre_pasajero TEXT NOT NULL,
    sexo            TEXT NOT NULL,
    edad            NUMERIC,
    sibsp           INTEGER NOT NULL,
    parch           INTEGER NOT NULL,
    sobrevivio      BOOLEAN NOT NULL,
    clase           INTEGER NOT NULL REFERENCES clase (clase),
    ticket          TEXT NOT NULL,
    tarifa          NUMERIC,
    embarque        INTEGER REFERENCES puerto (embarque),
    bote            TEXT,
    cuerpo          INTEGER,
    origen_destino  TEXT
);

CREATE TABLE IF NOT EXISTS pasajerocabina (
    pasajeros INTEGER NOT NULL REFERENCES pasajero (passengerid),
    cabinas   TEXT NOT NULL REFERENCES cabina (cabina),
    posicion  INTEGER NOT NULL,
    PRIMARY KEY (pasajeros, cabinas)
);

CREATE INDEX IF NOT EXISTS idx_pasajero__clase ON pasajero (clase);
CREATE INDEX IF NOT EXISTS idx_pasajero__embarque ON pasajero (embarque);
CREATE INDEX IF NOT EXISTS idx_pasajerocabina__cabinas ON pasajerocabina (cabinas);

INSERT INTO schema_migrations (version) VALUES ('000-modelo-inicial');
