SELECT DISTINCT continent FROM country ORDER BY continent;

--! Creamos la tabla continent para transferir los datos de la
--! columna continent de la tabla country a una tabla aparte
--! y así normalizar la base de datos
--! (1NF: First Normal Form)
CREATE TABLE continent (
    code SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

--! Insertamos los datos en la tabla continent
INSERT INTO
    continent (name)
SELECT DISTINCT
    continent
FROM country
ORDER BY continent;

-- Verificamos que los datos se hayan insertado correctamente
SELECT * FROM continent;

--! Realizamos un BACKUP de la tabla country
-- Opción 1: Crear una copia exacta de la tabla
CREATE TABLE country_backup AS TABLE country;
-- Opción 2: Crear una tabla vacía con la misma estructura
CREATE TABLE country_backup (
    code character(3) NOT NULL,
    name text NOT NULL,
    continent text NOT NULL,
    region text NOT NULL,
    surfacearea real NOT NULL,
    indepyear smallint,
    population integer NOT NULL,
    lifeexpectancy real,
    gnp numeric(10, 2),
    gnpold numeric(10, 2),
    localname text NOT NULL,
    governmentform text NOT NULL,
    headofstate text,
    capital integer,
    code2 character(2) NOT NULL,
    PRIMARY KEY (code),
    CONSTRAINT country_continent_check CHECK (
        (continent = 'Asia'::text)
        OR (
            continent = 'South America'::text
        )
        OR (
            continent = 'North America'::text
        )
        OR (continent = 'Oceania'::text)
        OR (
            continent = 'Antarctica'::text
        )
        OR (continent = 'Africa'::text)
        OR (continent = 'Europe'::text)
        OR (
            continent = 'Central America'::text
        )
    ),
    CONSTRAINT country_surfacearea_check CHECK (
        surfacearea >= (0)::double precision
    )
);
-- Copiamos los datos de la tabla country a la tabla country_backup
INSERT INTO country_backup SELECT * FROM country;

-- Verificamos que los datos se hayan copiado correctamente
SELECT * FROM country_backup;

--! Eliminamos el check de la columna continent de la tabla country
ALTER TABLE country DROP CONSTRAINT country_continent_check;

--! Actualizamos la tabla country para que la columna continent
--! haga referencia a la tabla continent

SELECT c.NAME, c.CONTINENT, (
        SELECT code
        FROM continent b
        WHERE
            b.NAME = c.continent
    )
FROM country c;

UPDATE country c
SET
    continent = (
        SELECT code
        FROM continent b
        WHERE
            b.NAME = c.continent
    );

-- Verificamos que los datos se hayan actualizado correctamente
SELECT * FROM country;

--! Modificamos la columna continent de la tabla country
--! para que sea de tipo INTEGER y haga referencia a la tabla continent
ALTER TABLE country
ALTER COLUMN continent TYPE INTEGER USING continent::INTEGER;

--! Agregamos la llave foránea a la columna continent de la tabla country
ALTER TABLE "country" ADD FOREIGN KEY ("continent") REFERENCES "continent"("code");

-- Verificamos que la llave foránea se haya agregado correctamente
SELECT * FROM country;

--! Eliminamos la tabla country_backup
DROP TABLE country_backup;

-- Verificamos que la tabla country_backup se haya eliminado correctamente
SELECT * FROM country_backup;