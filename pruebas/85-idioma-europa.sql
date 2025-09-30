

-- ¿Cuál es el idioma (y código del idioma) oficial más hablado por diferentes países en Europa?

select * from countrylanguage where isofficial = true;

select * from country;

select * from continent;

Select * from "language";

SELECT COUNT(*) AS TOTAL, L.NAME AS LANGUAGE, L.CODE
FROM LANGUAGE L
    JOIN COUNTRYLANGUAGE CL ON L.CODE = CL.languagecode
    JOIN COUNTRY C ON CL.COUNTRYCODE = C.CODE
    JOIN CONTINENT CON ON C.CONTINENT = CON.CODE
WHERE CON.NAME LIKE 'Europe' AND CL.ISOFFICIAL = TRUE
GROUP BY LANGUAGE, L.CODE
ORDER BY TOTAL DESC
LIMIT 1;


-- Listado de todos los países cuyo idioma oficial es el más hablado de Europa 
-- (no hacer subquery, tomar el código anterior)


SELECT L.NAME AS LANGUAGE, L.CODE, C.NAME
FROM LANGUAGE L
    JOIN COUNTRYLANGUAGE CL ON L.CODE = CL.languagecode
    JOIN COUNTRY C ON CL.COUNTRYCODE = C.CODE
    JOIN CONTINENT CON ON C.CONTINENT = CON.CODE
WHERE L.CODE = 135 AND CL.ISOFFICIAL = TRUE
ORDER BY C.NAME;




