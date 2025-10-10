--! Procedimientos Almacenados
-- Los procedimientos almacenados son conjuntos de instrucciones SQL que se almacenan en la base de datos y se pueden ejecutar bajo demanda.
-- Permiten encapsular lógica de negocio, mejorar el rendimiento y reutilizar código.

--? Función que regresa una tabla.

-- Esta función devuelve una tabla con los países y sus respectivas regiones.
CREATE OR REPLACE FUNCTION country_region()
RETURNS TABLE (id CHARACTER(2), name VARCHAR(40), region VARCHAR(25))
AS $$

BEGIN

	RETURN query
	SELECT country_id, country_name, region_name
	FROM countries
	JOIN regions ON countries.region_id = regions.region_id;

END;

$$ LANGUAGE plpgsql;

-- Ejecución de la función
-- La función se puede llamar utilizando una sentencia SELECT.
SELECT * FROM country_region();


--? Procedimiento almacenado para insertar una nueva región.

-- Este procedimiento inserta una nueva región en la tabla regions.
-- Toma dos parámetros: el ID de la región y el nombre de la región.
CREATE OR REPLACE PROCEDURE insert_region_proc(INT, VARCHAR)
AS $$

BEGIN

	INSERT INTO regions(region_id, region_name)
	VALUES($1, $2);
	
	RAISE NOTICE 'Variable 1: %, %', $1, $2;
	
	--ROLLBACK;
	COMMIT;

END;

$$ LANGUAGE plpgsql;

-- Ejecución del procedimiento almacenado
-- El procedimiento se puede llamar utilizando la sentencia CALL.
CALL insert_region_proc(5, 'Central America');

-- Verificación de la inserción
SELECT * FROM regions;


--? Procedimiento almacenado de aumento salarial.

-- Esta función calcula el aumento salarial máximo que un empleado puede recibir basado en su salario actual y el salario máximo permitido para su puesto.
-- Si el salario actual es mayor que el salario máximo, el aumento será 0.
CREATE OR REPLACE FUNCTION max_raise( empl_id int )
returns NUMERIC(8,2) as $$

DECLARE
	possible_raise NUMERIC(8,2);

BEGIN
	
	select 
		max_salary - salary into possible_raise
	from employees
	INNER JOIN jobs on jobs.job_id = employees.job_id
	WHERE employee_id = empl_id;

	if ( possible_raise < 0 ) THEN
		possible_raise = 0;
	end if;

	return possible_raise;

END;
$$ LANGUAGE plpgsql;

-- Ejecución de la función
-- La función se puede llamar utilizando una sentencia SELECT.
SELECT max_raise(101);

-- Ejemplo de uso en un contexto más amplio
-- Aquí se muestra cómo utilizar la función max_raise en una consulta para calcular el aumento salarial para todos los empleados.
SELECT
	CURRENT_DATE AS "date",
	salary,
	max_raise(employee_id),
	max_raise(employee_id) * 0.05 AS amount,
	5 AS percentage
FROM employees;

-- Este procedimiento realiza un aumento salarial controlado para todos los empleados.
-- Toma un parámetro que indica el porcentaje de aumento.
CREATE OR REPLACE PROCEDURE controlled_raise (percentage NUMERIC)
AS $$

DECLARE
	real_percentage NUMERIC(8, 2);
	total_employees int;

BEGIN

	real_percentage = percentage / 100; --5% = 0.05
	
	-- Mantener el historico
	INSERT INTO raise_history(date, employee_id, base_salary, amount, percentage)
	SELECT
		CURRENT_DATE AS "date",
		employee_id,
		salary,
		max_raise(employee_id) * real_percentage AS amount,
		percentage
	FROM employees;
	
	-- Impactar la tabla de empleados
	UPDATE employees
	SET salary = salary + (max_raise(employee_id) * real_percentage);
	
	COMMIT;
	
	SELECT COUNT(*) INTO total_employees FROM employees;
	
	RAISE NOTICE '% Usuarios Afectados', total_employees;

END;

$$ LANGUAGE plpgsql;

-- Ejecución del procedimiento almacenado
-- El procedimiento se puede llamar utilizando la sentencia CALL.
CALL controlled_raise(10);

-- Verificación de los resultados
SELECT * FROM raise_history;
SELECT * FROM employees;