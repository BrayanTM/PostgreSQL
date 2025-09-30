--! UNION: Combina los resultados de dos consultas SELECT, eliminando duplicados pero ambas consultas deben tener el mismo número de columnas y tipos compatibles.
-- Aquí se combinan dos conjuntos de resultados: uno que selecciona continentes con códigos específicos y otro que selecciona continentes cuyo nombre contiene 'America'.
SELECT *
FROM continent
WHERE
    code IN (3, 5, 7)
UNION
SELECT *
FROM continent
WHERE
    NAME LIKE '%America%'
ORDER BY name;

--! UNION ALL: Similar a UNION, pero incluye todos los registros, incluso duplicados.
-- Aquí se combinan dos conjuntos de resultados sin eliminar duplicados.
SELECT *
FROM continent
WHERE
    code IN (4, 6, 8)
UNION ALL
SELECT *
FROM continent
WHERE
    NAME LIKE '%America%'
ORDER BY name;

--! WHERE: Filtra los resultados de una consulta basándose en una condición específica.
-- Aquí se seleccionan países y sus continentes correspondientes utilizando una condición en la cláusula WHERE para unir las tablas.
SELECT a.name AS COUNTRY, b.NAME AS CONTINENT
FROM country a, continent b
WHERE
    a.continent = b.code
ORDER BY b.NAME;

--! INNER JOIN: Devuelve filas cuando hay una coincidencia en ambas tablas.
-- Aquí se seleccionan países y sus continentes correspondientes utilizando una cláusula JOIN para unir las tablas.
SELECT a.name AS country, b.name AS continent
FROM country a
    INNER JOIN continent b ON a.continent = b.code
ORDER BY a.name;

--! ALTER SEQUENCE: Modifica una secuencia existente, en este caso, reiniciando el valor con el que comenzará la próxima generación de números.
-- Se insertan nuevos continentes para demostrar los joins.
insert into continent (name) values ('North Asia');

-- Se reinicia la secuencia para que el próximo código asignado sea 10.
ALTER SEQUENCE "continent_code_seq" RESTART WITH 10;

--! FULL OUTER JOIN: Devuelve todas las filas cuando hay una coincidencia en una de las tablas. Si no hay coincidencia, el resultado es NULL en el lado sin coincidencia.
-- Aquí se seleccionan todos los países y continentes, mostrando NULL donde no hay coincidencia.
SELECT
    a.name as country,
    a.continent as code,
    b.name as continent_name
FROM country a
    FULL OUTER JOIN continent b ON a.continent = b.code
ORDER BY a.name DESC;

--! RIGHT OUTER JOIN (CON EXCLUSION): Devuelve todas las filas de la tabla de la derecha y las filas coincidentes de la tabla de la izquierda. Si no hay coincidencia, el resultado es NULL en el lado izquierdo. Aquí se filtran los resultados para mostrar solo aquellos continentes que no tienen países asociados.
-- Selecciona continentes sin países asociados.
SELECT a.name AS country, b.name AS continent
FROM country a
    RIGHT JOIN continent b ON a.continent = b.code
WHERE
    a.continent IS NULL;

--! AGREGATIONS + JOINS: Combina funciones de agregación con una cláusula JOIN para resumir datos relacionados de dos tablas.
--- Contar el número de países por continente, mostrando todos los continentes, excluyendo aquellos sin países asociados.
SELECT COUNT(*), A.CONTINENT, B.NAME AS CONTINENT_NAME
FROM COUNTRY A
    INNER JOIN CONTINENT B ON A.CONTINENT = B.CODE
GROUP BY
    A.CONTINENT,
    B.NAME
ORDER BY COUNT(*);

--- Contar el número de países por continente, incluyendo continentes sin países asociados.
SELECT COUNT(*), A.CONTINENT, B.NAME AS CONTINENT_NAME
FROM COUNTRY A
    FULL OUTER JOIN CONTINENT B ON A.CONTINENT = B.CODE
GROUP BY
    A.CONTINENT,
    B.NAME
ORDER BY COUNT(*);

--- Contar el número de países por continente, incluyendo continentes sin países asociados, usando UNION para asegurar que todos los continentes se muestren y asignar 0 a aquellos sin países.
(
    SELECT 0 AS COUNT, A.CONTINENT, B.NAME AS CONTINENT_NAME
    FROM COUNTRY A
        RIGHT OUTER JOIN CONTINENT B ON A.CONTINENT = B.CODE
    WHERE
        A.CONTINENT IS NULL
    GROUP BY
        A.CONTINENT,
        B.NAME
)
UNION
(
    SELECT COUNT(*) AS COUNT, A.CONTINENT, B.NAME AS CONTINENT_NAME
    FROM COUNTRY A
        INNER JOIN CONTINENT B ON A.CONTINENT = B.CODE
    GROUP BY
        A.CONTINENT,
        B.NAME
)
ORDER BY COUNT;

--! MULTIPLE JOINS CON AGRUPACIONES: Realiza múltiples uniones entre tablas y agrupa los resultados para obtener resúmenes detallados.

-- ¿Quiero saber los idiomas oficiales que se hablan por continente?

SELECT * FROM COUNTRYLANGUAGE WHERE ISOFFICIAL = TRUE;

SELECT * FROM COUNTRY;

SELECT * FROM CONTINENT;

SELECT DISTINCT
    A.NAME,
    D.NAME AS CONTINENT
FROM
    LANGUAGE A
    JOIN COUNTRYLANGUAGE B ON A.CODE = B.LANGUAGECODE
    JOIN COUNTRY C ON B.COUNTRYCODE = C.CODE
    JOIN CONTINENT D ON D.CODE = C.CONTINENT
WHERE
    B.ISOFFICIAL = TRUE
ORDER BY CONTINENT;

-- ¿Cuántos idiomas oficiales se hablan por continente?

SELECT COUNT(*) AS TOTAL, CONTINENT
FROM (
        SELECT DISTINCT
            A.NAME, D.NAME AS CONTINENT
        FROM
            LANGUAGE A
            JOIN COUNTRYLANGUAGE B ON A.CODE = B.LANGUAGECODE
            JOIN COUNTRY C ON B.COUNTRYCODE = C.CODE
            JOIN CONTINENT D ON D.CODE = C.CONTINENT
        WHERE
            B.ISOFFICIAL = TRUE
    ) AS LENGUAS
GROUP BY
    CONTINENT
ORDER BY TOTAL;