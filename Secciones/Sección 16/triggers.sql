--! Triggers
-- Los triggers son procedimientos almacenados que se ejecutan automáticamente en respuesta a ciertos eventos en una tabla o vista.

-- Crear una tabla para registrar las sesiones de usuario
CREATE TABLE IF NOT EXISTS "session" (
    "session_id" SERIAL PRIMARY KEY,
    "user_id" INT REFERENCES "user"(user_id),
    "last_login" TIMESTAMP
);

-- Crear un trigger que se active después de una actualización en la tabla "user"
-- Este trigger llamará a la función create_session_log para insertar un registro en la tabla "session"
CREATE OR REPLACE TRIGGER create_session_trigger AFTER UPDATE ON "user"
FOR EACH ROW EXECUTE PROCEDURE create_session_log();

-- Crear la función que será llamada por el trigger
CREATE OR REPLACE FUNCTION create_session_log()
RETURNS TRIGGER
AS $$

BEGIN

	INSERT INTO "session" (user_id, last_login)
	VALUES(NEW.user_id, now());
	
	RETURN NEW;

END;

$$ LANGUAGE plpgsql;

-- Prueba del trigger
CALL user_login('Jose', '123456');

-- Verificar que se haya creado un registro en la tabla session
SELECT * FROM "session";

--? Trigger When

-- Crear un trigger que solo se active si la columna last_login ha cambiado
-- Esto evita que se cree un registro en la tabla session si se actualizan otras columnas de la tabla user sin cambiar last_login
CREATE OR REPLACE TRIGGER create_session_trigger 
AFTER UPDATE ON "user"
FOR EACH ROW
WHEN (OLD.last_login IS DISTINCT FROM NEW.last_login)
EXECUTE FUNCTION create_session_log();

CREATE OR REPLACE FUNCTION create_session_log()
RETURNS TRIGGER
AS $$

BEGIN

	INSERT INTO "session" (user_id, last_login)
	VALUES(NEW.user_id, now());
	
	RETURN NEW;

END;

$$ LANGUAGE plpgsql;


CALL user_login('Jose', '123456');