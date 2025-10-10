--! Vistas Materializadas
-- Una vista materializada es una vista que almacena físicamente los datos resultantes de una consulta SQL.
-- A diferencia de las vistas normales, las vistas materializadas no se actualizan automáticamente cuando cambian los datos subyacentes.
-- En su lugar, deben ser actualizadas manualmente o mediante un programa de actualización.

--? Crear una vista materializada

-- Esta vista materializada nos permitirá ver el rendimiento de los posts por semana en términos de aplausos (claps) y número de posts.
-- La vista agrupa los datos por semana, sumando el total de aplausos y contando el número de posts y aplausos.
CREATE MATERIALIZED VIEW comments_per_week_mat AS
SELECT date_trunc('week'::text, posts.created_at) AS weeks,
    sum(claps.counter) AS total_claps,
    count(DISTINCT posts.post_id) AS number_of_posts,
    count(*) AS number_of_claps
   FROM (posts
     JOIN claps ON ((claps.post_id = posts.post_id)))
  GROUP BY (date_trunc('week'::text, posts.created_at))
  ORDER BY (date_trunc('week'::text, posts.created_at)) DESC;

-- Consultar una vista
select * FROM comments_per_week;

-- Consultar una vista materializada
select * FROM comments_per_week_mat;

-- Actualizar una vista materializada
-- La vista materializada no se actualiza automáticamente, por lo que debemos refrescarla manualmente.
-- Esto puede ser costoso en términos de rendimiento, especialmente si la consulta subyacente es compleja o si los datos cambian con frecuencia.
-- Por lo tanto, es importante considerar cuándo y con qué frecuencia se debe actualizar la vista materializada.
-- En este caso, simplemente la refrescamos para asegurarnos de que los datos estén actualizados.
REFRESH MATERIALIZED VIEW comments_per_week_mat;

select * from posts where post_id = 1;

-- Eliminar una vista materializada
DROP MATERIALIZED VIEW comments_per_week_mat;

-- Renombrar una vista materializada
ALTER MATERIALIZED VIEW comments_per_week_mat RENAME TO posts_per_week_mat;