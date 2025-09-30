-- 1. Cuantos usuarios tenemos con cuentas @google.com
-- Tip: count, like

SELECT COUNT(*) FROM USERS WHERE EMAIL LIKE '%@google.com';

-- 2. De qué países son los usuarios con cuentas de @google.com
-- Tip: distinct

SELECT DISTINCT (COUNTRY) FROM USERS WHERE EMAIL LIKE '%@google.com';

-- 3. Cuantos usuarios hay por país (country)
-- Tip: Group by

SELECT COUNT(*) AS "CANTIDAD", COUNTRY
FROM USERS
GROUP BY
    COUNTRY
ORDER BY "CANTIDAD" DESC;

-- 4. Listado de direcciones IP de todos los usuarios de Iceland
-- Campos requeridos first_name, last_name, country, last_connection

SELECT
    FIRST_NAME,
    LAST_NAME,
    COUNTRY,
    LAST_CONNECTION
FROM USERS
WHERE
    COUNTRY = 'Iceland';

-- 5. Cuantos de esos usuarios (query anterior) tiene dirección IP
-- que incia en 112.XXX.XXX.XXX

SELECT COUNT(*)
FROM USERS
WHERE
    COUNTRY = 'Iceland'
    AND LAST_CONNECTION LIKE '112.%';

-- 6. Listado de usuarios de Iceland, tienen dirección IP
-- que inicia en 112 ó 28 ó 188
-- Tip: Agrupar condiciones entre paréntesis

SELECT
    FIRST_NAME,
    LAST_NAME,
    COUNTRY,
    LAST_CONNECTION
FROM USERS
WHERE
    COUNTRY = 'Iceland'
    AND (
        LAST_CONNECTION LIKE '112.%'
        OR LAST_CONNECTION LIKE '28.%'
        OR LAST_CONNECTION LIKE '188.%'
    );

-- 7. Ordene el resultado anterior, por apellido (last_name) ascendente
-- y luego el first_name ascendentemente también

SELECT
    FIRST_NAME,
    LAST_NAME,
    COUNTRY,
    LAST_CONNECTION
FROM USERS
WHERE
    COUNTRY = 'Iceland'
    AND (
        LAST_CONNECTION LIKE '112.%'
        OR LAST_CONNECTION LIKE '28.%'
        OR LAST_CONNECTION LIKE '188.%'
    )
ORDER BY LAST_NAME ASC, FIRST_NAME ASC;

-- 8. Listado de personas cuyo país está en este listado
-- ('Mexico', 'Honduras', 'Costa Rica')
-- Ordenar los resultados de por País asc, Primer nombre asc, apellido asc
-- Tip: Investigar IN
-- Tip2: Ver Operadores de Comparación en la hoja de atajos (primera página)

SELECT *
FROM USERS
WHERE
    COUNTRY IN (
        'Mexico',
        'Honduras',
        'Costa Rica',
        'Guatemala'
    )
ORDER BY
    COUNTRY ASC,
    FIRST_NAME ASC,
    LAST_NAME ASC;

-- 9. Del query anterior, cuente cuántas personas hay por país
-- Ordene los resultados por País asc

SELECT COUNT(*), COUNTRY
FROM USERS
WHERE
    COUNTRY IN (
        'Mexico',
        'Honduras',
        'Costa Rica',
        'Guatemala'
    )
GROUP BY
    COUNTRY
ORDER BY COUNTRY ASC;