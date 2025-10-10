--! Vistas
-- Una vista es una tabla virtual basada en el conjunto de resultados de una consulta SQL.
-- Las vistas no almacenan datos físicamente, sino que generan los datos dinámicamente cuando se consultan.
-- Son útiles para simplificar consultas complejas, mejorar la seguridad al restringir el acceso a ciertos datos,
-- y proporcionar una capa de abstracción sobre las tablas subyacentes.

--? Crear una vista

-- Esta vista nos permitirá ver el rendimiento de los posts por semana en términos de aplausos (claps) y número de posts.
-- La vista agrupa los datos por semana, sumando el total de aplausos y contando el número de posts y aplausos.
create or replace view comments_per_week as
select
    date_trunc ('week', posts.created_at) as weeks,
    sum(claps.counter) as total_claps,
    count(DISTINCT posts.post_id) as number_of_posts,
    count(*) as number_of_claps
from posts
    join claps on claps.post_id = posts.post_id
group by
    weeks
order by weeks desc;

select * from posts where post_id = 1;

-- Consultar una vista
select * from comments_per_week;

-- Eliminar una vista
drop view comments_per_week;

-- Renombrar una vista
ALTER VIEW comments_per_week RENAME TO posts_per_week;