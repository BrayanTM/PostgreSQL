--! Ejemplo sin recursividad - Recomendaciones de Twitter
-- En este ejemplo, simulamos un sistema de recomendaciones de seguidores en Twitter.

-- La tabla followers contiene relaciones de seguidores y líderes.
-- La consulta selecciona los seguidores y líderes, uniendo la tabla followers con la tabla user para obtener los nombres correspondientes.
-- Esto nos permite ver quién sigue a quién en la plataforma.
SELECT followers.leader_id, leader."name" as leader, followers.follower_id, follower."name" as follower
FROM followers
JOIN "user" leader ON leader.id = followers.leader_id
JOIN "user" follower ON follower.id = followers.follower_id;

--? Sugerencias de personas a seguir

-- Primero, seleccionamos los seguidores del usuario con leader_id = 1.
SELECT follower_id FROM followers WHERE leader_id = 1;

-- Ahora, para sugerir nuevas personas a seguir, buscamos los seguidores de los seguidores del usuario con leader_id = 1.
-- Excluimos a las personas que el usuario ya sigue y al propio usuario.
SELECT * FROM followers
WHERE leader_id in (SELECT follower_id FROM followers WHERE leader_id = 1)
AND follower_id NOT IN (SELECT follower_id FROM followers WHERE leader_id = 1);