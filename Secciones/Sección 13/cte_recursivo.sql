-- CTE Recursivo
-- Nos permiten realizar consultas recursivas, es decir, consultas que se llaman a sí mismas.
-- Son útiles para trabajar con datos jerárquicos o estructuras de árbol, como árboles genealógicos, estructuras organizativas o grafos.
-- Una CTE recursiva consta de dos partes: la parte base y la parte recursiva.
-- La parte base define el punto de partida de la recursión, mientras que la parte recursiva define cómo se deben combinar los resultados de la parte base para generar nuevos resultados.
-- La recursión continúa hasta que no se generan nuevos resultados.
-- Es importante tener cuidado al usar CTEs recursivas, ya que pueden llevar a bucles infinitos si no se definen correctamente las condiciones de terminación.

--? Crear una CTE recursiva

-- En este ejemplo, creamos una CTE recursiva llamada countdown que cuenta hacia atrás desde 5 hasta 1.
-- La parte base es el valor inicial (5) y la parte recursiva resta 1 al valor actual hasta que el valor es mayor que 1.
-- Luego, seleccionamos todos los valores generados por la CTE.
WITH RECURSIVE
    countdown (val) AS (
        VALUES (5)
        UNION ALL
        SELECT val - 1
        FROM countdown
        WHERE
            val > 1
    )
SELECT *
FROM countdown;

-- Otro ejemplo de CTE recursiva que cuenta hacia arriba desde 1 hasta 10.
-- La parte base es el valor inicial (1) y la parte recursiva suma 1 al valor actual hasta que el valor es menor que 10.
-- Luego, seleccionamos todos los valores generados por la CTE.
WITH RECURSIVE
    count_asc (val) AS (
        VALUES (1)
        UNION ALL
        SELECT val + 1
        FROM count_asc
        WHERE
            val < 10
    )
SELECT *
FROM count_asc;

-- Ejemplo más complejo de CTE recursiva que genera una tabla de multiplicar del 5.
-- La parte base define el primer valor de la tabla de multiplicar (5 x 1 = 5).
-- La parte recursiva incrementa el multiplicador y calcula el resultado hasta que el multiplicador es menor que 10.
-- Luego, seleccionamos todos los valores generados por la CTE.
WITH RECURSIVE
    multip_table (val1, val2, val3, val4) AS (
        VALUES (5, 'x', 1, 5)
        UNION ALL
        SELECT
            val1 AS "BASE",
            val2 AS "SIGN",
            val3 + 1 AS "MULTIPLIER",
            val1 * (val3 + 1) AS "RESULT"
        FROM multip_table
        WHERE
            val3 < 10
    )
SELECT *
FROM multip_table;