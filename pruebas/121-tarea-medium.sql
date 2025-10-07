-- 1. Cuantos Post hay - 1050
select count(*) from posts;

-- 2. Cuantos Post publicados hay - 543
select count(*) from posts where published=True;

-- 3. Cual es el Post mas reciente
-- 544 - nisi commodo officia...2024-05-30 00:29:21.277
select * from posts
order by created_at desc
limit 1;


-- 4. Quiero los 10 usuarios con más post, cantidad de posts, id y nombre
/*
4	1553	Jessie Sexton
3	1400	Prince Fuentes
3	1830	Hull George
3	470	Traci Wood
3	441	Livingston Davis
3	1942	Inez Dennis
3	1665	Maggie Davidson
3	524	Lidia Sparks
3	436	Mccoy Boone
3	2034	Bonita Rowe
*/
select 
	count(*) as posts,
	u.user_id as id, 
	u.name as user
from users u
join posts p on u.user_id = p.created_by
group by id, user
order by posts desc
limit 10;


-- 5. Quiero los 5 post con más "Claps" sumando la columna "counter"
/*
692	sit excepteur ex ipsum magna fugiat laborum exercitation fugiat
646	do deserunt ea
542	do
504	ea est sunt magna consectetur tempor cupidatat
502	amet exercitation tempor laborum fugiat aliquip dolore
*/
select
	sum(c.counter) as claps,
	p.title as post
from posts p
join claps c on p.post_id = c.post_id
group by post
order by claps desc
limit 5;


-- 6. Top 5 de personas que han dado más claps (voto único no acumulado ) *count
/*
7	Lillian Hodge
6	Dominguez Carson
6	Marva Joyner
6	Lela Cardenas
6	Rose Owen
*/
select
	count(*) as claps,
	u.name as name
from users u
join claps c on u.user_id = c.user_id
group by name
order by claps desc
limit 5;



-- 7. Top 5 personas con votos acumulados (sumar counter)
/*
437	Rose Owen
394	Marva Joyner
386	Marquez Kennedy
379	Jenna Roth
364	Lillian Hodge
*/
select
	sum(c.counter) as claps,
	u.name as name
from users u
join claps c on u.user_id = c.user_id
group by name
order by claps desc
limit 5;


-- 8. Cuantos usuarios NO tienen listas de favoritos creada
-- 329
select count(*)
from users u
left join user_lists ul on u.user_id = ul.user_id
where ul.user_id is null;


-- 9. Quiero el comentario con id #1
-- Y en el mismo resultado, quiero sus respuestas (visibles e invisibles)
-- Tip: union
/*
1	    648	1905	elit id...
3058	583	1797	tempor mollit...
4649	51	1842	laborum mollit...
4768	835	1447	nostrud nulla...
*/
select * from comments where comment_id = 1
union
select * from comments where comment_parent_id = 1
order by comment_id asc;


-- ** 10. Avanzado
-- Investigar sobre el json_agg y json_build_object
-- Crear una única linea de respuesta, con las respuestas
-- del comentario con id 1 (comment_parent_id = 1)
-- Mostrar el user_id y el contenido del comentario

-- Salida esperada:
/*
"[{""user"" : 1797, ""comment"" : ""tempor mollit aliqua dolore cupidatat dolor tempor""}, {""user"" : 1842, ""comment"" : ""laborum mollit amet aliqua enim eiusmod ut""}, {""user"" : 1447, ""comment"" : ""nostrud nulla duis enim duis reprehenderit laboris voluptate cupidatat""}]"
*/

SELECT json_agg(json_build_object('user', user_id, 'comment', content)) AS responses
FROM comments
where comment_parent_id = 1;




-- ** 11. Avanzado
-- Listar todos los comentarios principales (no respuestas) 
-- Y crear una columna adicional "replies" con las respuestas en formato JSON

--? Si encuentra un comentario sin respuestas, el valor de "replies" es un diccionario vacío {}
SELECT
    c.comment_id,
    c.post_id,
    c.content,
    json_agg(json_build_object('user', c2.user_id, 'comment', c2.content)) AS replies
FROM comments c
LEFT JOIN comments c2 ON c.comment_id = c2.comment_parent_id
WHERE c.comment_parent_id IS NULL
GROUP BY c.comment_id;

--? Si encuentra un comentario sin respuestas, el valor de "replies" es NULL
SELECT
    c.*,
    (
		select
			json_agg(json_build_object('user', c2.user_id, 'comment', c2.content))
		from comments c2
		where c2.comment_parent_id = c.comment_id
	)  AS replies
FROM comments c
WHERE c.comment_parent_id IS NULL;