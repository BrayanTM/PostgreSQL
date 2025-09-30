-- Nombre, apellido e IP, donde la última conexión se dió de 221.XXX.XXX.XXX
SELECT
    FIRST_NAME,
    LAST_NAME,
    LAST_CONNECTION
FROM USERS
WHERE
    LAST_CONNECTION LIKE '221.%';

-- Nombre, apellido y seguidores(followers) de todos a los que lo siguen más de 4600 personas
SELECT FIRST_NAME, LAST_NAME, FOLLOWERS
FROM USERS
WHERE
    FOLLOWERS > 4600;