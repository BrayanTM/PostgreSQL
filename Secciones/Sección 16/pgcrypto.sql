--! Extensión pgcrypto
-- Proporciona funciones criptográficas y de hashing para PostgreSQL.

-- Crear la extensión pgcrypto
CREATE EXTENSION pgcrypto;

-- Crear una tabla de usuarios con una columna para almacenar contraseñas cifradas
-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS user_user_id_seq;

-- Table Definition
CREATE TABLE "public"."user" (
    "user_id" int4 NOT NULL DEFAULT nextval('user_user_id_seq'::regclass),
    "username" varchar(50),
    "password" text,
    "last_login" timestamp,
    PRIMARY KEY ("user_id")
);

-- Insertar usuarios con contraseñas cifradas usando la función crypt y gen_salt de pgcrypto
INSERT INTO "user"(username, "password")
VALUES('Brayan',
	   crypt('123456', gen_salt('bf')));

-- Insertar otro usuario
INSERT INTO "user"(username, "password")
VALUES('Jose',
       crypt('123456', gen_salt('bf')));

-- Verificar la contraseña de un usuario
-- La función crypt compara la contraseña proporcionada con la almacenada en la base de datos y devuelve true si coinciden
SELECT * 
FROM "user"
WHERE username = 'Jose' 
and "password" = crypt('123456', "password");