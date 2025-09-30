-- Quiero que me muestren el país con más ciudades.
-- Campos: total de ciudades Y el nombre del país
-- usar INNER JOIN


SELECT * FROM CITY;
SELECT * FROM COUNTRY;

SELECT 
    COUNT(*) AS "Total", B.NAME AS "Country"
FROM CITY A
    INNER JOIN COUNTRY B ON A.COUNTRYCODE = B.code
GROUP BY B.NAME
ORDER BY "Total" DESC
LIMIT 1;