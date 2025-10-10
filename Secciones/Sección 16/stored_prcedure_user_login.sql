--! Procedimiento almacenado para el inicio de sesión de usuarios

-- Este procedimiento verifica las credenciales del usuario y actualiza la última fecha de inicio de sesión si son correctas.
-- Si las credenciales son incorrectas, registra el intento fallido en la tabla session_failed.
CREATE OR REPLACE PROCEDURE user_login(user_name VARCHAR, user_password VARCHAR)
AS $$

DECLARE
	was_found BOOLEAN;

BEGIN

	SELECT COUNT(*) INTO was_found
	FROM "user"
	WHERE username = user_name
	and "password" = crypt(user_password, "password");
	
	IF (was_found = FALSE) THEN
	
		INSERT INTO session_failed(username, "when")
		VALUES(user_name, now());
		
		COMMIT;
		
		RAISE EXCEPTION 'Usuario y contrasenia no son correctos';
	
	END IF;
	
	UPDATE "user"
	SET last_login = now()
	WHERE username = user_name;
	
	COMMIT;
	
	RAISE NOTICE 'Usuario Encontrado: %', was_found;

END;

$$ LANGUAGE plpgsql;

-- Ejemplo de llamada al procedimiento almacenado
-- Supongamos que queremos iniciar sesión con el usuario 'Jose' y la contraseña '123456'
--
CALL user_login('Jose', '123456');