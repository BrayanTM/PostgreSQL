-- Count Union - Tarea
-- Total |  Continent
-- 5	  | Antarctica
-- 28	  | Oceania
-- 46	  | Europe
-- 51	  | America
-- 51	  | Asia
-- 58	  | Africa

(
    SELECT COUNT(*) AS "Total", B.NAME AS "Continent"
    FROM COUNTRY A
        INNER JOIN CONTINENT B ON A.CONTINENT = B.CODE
    WHERE
        B.NAME NOT LIKE '%America%'
    GROUP BY
        "Continent"
)
UNION
(
    SELECT COUNT(*) AS "Total", 'America'
    FROM COUNTRY A
        INNER JOIN CONTINENT B ON A.CONTINENT = B.CODE
    WHERE
        B.NAME LIKE '%America%'
)
ORDER BY "Total";

-- Mas eficiente utilizar IN en lugar de LIKE
(
    SELECT COUNT(*) AS "Total", B.NAME AS "Continent"
    FROM COUNTRY A
        INNER JOIN CONTINENT B ON A.CONTINENT = B.CODE
    WHERE
        B.CODE NOT IN (4, 6, 8)
    GROUP BY
        "Continent"
)
UNION
(
    SELECT COUNT(*) AS "Total", 'America'
    FROM COUNTRY A
        INNER JOIN CONTINENT B ON A.CONTINENT = B.CODE
    WHERE
        B.CODE IN (4, 6, 8)
)
ORDER BY "Total";