--! Common Table Expressions (CTE)
-- Nos permiten crear una especie de tabla temporal que solo existe durante la ejecución de una consulta.
-- Son útiles para mejorar la legibilidad y organización de consultas complejas, especialmente cuando se reutilizan subconsultas.
-- También pueden ayudar a optimizar el rendimiento al evitar la repetición de subconsultas.

--? Crear una CTE

-- Esta CTE nos permitirá ver el rendimiento de los posts por semana en términos de aplausos (claps) y número de posts.
-- La CTE agrupa los datos por semana, sumando el total de aplausos y contando el número de posts y aplausos.
-- Luego, en la consulta principal, filtramos los resultados para mostrar solo las semanas del año 2024 con al menos 600 aplausos.
WITH posts_week_2024 AS (
SELECT date_trunc('week'::text, posts.created_at) AS weeks,
    sum(claps.counter) AS total_claps,
    count(DISTINCT posts.post_id) AS number_of_posts,
    count(*) AS number_of_claps
   FROM posts
     JOIN claps ON claps.post_id = posts.post_id
  GROUP BY (date_trunc('week'::text, posts.created_at))
  ORDER BY (date_trunc('week'::text, posts.created_at)) DESC
)
SELECT * FROM posts_week_2024
WHERE weeks BETWEEN '2024-01-01' and '2024-12-31' and total_claps >= 600;

--? Multiples CTEs

-- En este ejemplo, usamos dos CTEs:
-- 1. claps_per_post: Calcula el total de aplausos por post.
-- 2. post_from_2023: Filtra los posts creados en el año 2023.
-- Luego, en la consulta principal, seleccionamos los posts que tienen aplausos y fueron creados en 2023.
WITH
    claps_per_post AS (
        SELECT post_id, SUM(counter)
        FROM claps
        GROUP BY
            post_id
    ),
    post_from_2023 AS (
        SELECT *
        FROM posts
        WHERE
            created_at BETWEEN '2023-01-01' AND '2023-12-31'
    )
SELECT *
FROM claps_per_post
WHERE
    claps_per_post.post_id IN (
        SELECT post_id
        FROM post_from_2023
    );