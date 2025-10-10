--! Funciones Personalizadas

--? Crear nuestra primer función

-- Creamos la función greet_employee que recibe un parámetro emp_name de tipo VARCHAR
-- y retorna un valor de tipo VARCHAR.
CREATE OR REPLACE FUNCTION greet_employee(emp_name VARCHAR)
RETURNS VARCHAR
AS $$
-- DECLARE

BEGIN
	RETURN 'Hola ' || emp_name;
END;

$$
LANGUAGE plpgsql;

-- Probar la función
SELECT greet_employee('Jose');

-- Usar la función en una consulta
SELECT first_name, greet_employee(first_name) FROM employees;


--? Problema: Determinar un posible aumento salarial

-- Queremos saber cuánto podría aumentar el salario de cada empleado
-- para llegar al salario máximo de su puesto.

-- Primero, veamos cómo obtener esa información con una consulta SQL
-- sin usar funciones.
SELECT 
	employee_id, 
	first_name, 
	salary, 
	max_salary,
	max_salary - salary AS possible_raise
FROM employees
JOIN jobs ON jobs.job_id = employees.job_id;

-- Ahora, encapsulemos esa lógica en una función que reciba el ID del empleado
-- y retorne el posible aumento salarial.
CREATE OR REPLACE FUNCTION max_raise(empl_id int)
RETURNS NUMERIC(8, 2) 
AS $$

DECLARE
	possible_raise NUMERIC(8, 2);

BEGIN

	SELECT 
		max_salary - salary INTO possible_raise
	FROM employees
	JOIN jobs ON jobs.job_id = employees.job_id
	WHERE employee_id = empl_id;
	
	RETURN possible_raise;

END;

$$ LANGUAGE plpgsql;

-- Probar la función
SELECT max_raise(101);

-- Usar la función en una consulta
SELECT employee_id, first_name, max_raise(employee_id) FROM employees;


--? Función con múltiples queries y parámetros

-- Ahora, reescribamos la función max_raise para que use múltiples queries
-- y variables declaradas dentro de la función.
CREATE OR REPLACE FUNCTION max_raise2(empl_id int)
RETURNS NUMERIC(8, 2) 
AS $$

DECLARE
	employee_job_id INT;
	current_salary NUMERIC(8, 2);
	
	job_max_salary NUMERIC(8, 2);
	possible_raise NUMERIC(8, 2);

BEGIN

	-- Tomar el puesto de trabajo y el salario.
	SELECT
		job_id,
		salary
		INTO employee_job_id, current_salary
	FROM employees
	WHERE employee_id = empl_id;
	
	-- Tomar el max_salary, acorde a su job.
	SELECT
		max_salary
		INTO job_max_salary
	FROM jobs
	WHERE job_id = employee_job_id;
	
	-- Calculos.
	possible_raise = job_max_salary - current_salary;
	
	
	RETURN possible_raise;

END;

$$ LANGUAGE plpgsql;

-- Probar la función
SELECT max_raise2(101);

-- Usar la función en una consulta
SELECT employee_id, first_name, max_raise2(employee_id) FROM employees;


--? Función con condicionales (IF, THEN, ELSE, END IF) y excepciones.

-- Ahora, modifiquemos la función max_raise2 para que maneje el caso
-- en que el salario actual es mayor al salario máximo del puesto.
CREATE OR REPLACE FUNCTION max_raise2(empl_id int)
RETURNS NUMERIC(8, 2) 
AS $$

DECLARE
	employee_job_id INT;
	current_salary NUMERIC(8, 2);
	
	job_max_salary NUMERIC(8, 2);
	possible_raise NUMERIC(8, 2);

BEGIN

	-- Tomar el puesto de trabajo y el salario.
	SELECT
		job_id,
		salary
		INTO employee_job_id, current_salary
	FROM employees
	WHERE employee_id = empl_id;
	
	-- Tomar el max_salary, acorde a su job.
	SELECT
		max_salary
		INTO job_max_salary
	FROM jobs
	WHERE job_id = employee_job_id;
	
	-- Calculos.
	possible_raise = job_max_salary - current_salary;
	
	-- Condiciones y Excepciones
	IF (possible_raise <= 0) THEN
		
		RAISE EXCEPTION 'Persona con salario mayor a max_salary: %', empl_id;
		--possible_raise = 0;
	
	END IF;
		
	RETURN possible_raise;

END;

$$ LANGUAGE plpgsql;

-- Probar la función
SELECT max_raise2(206);  -- Este empleado tiene un salario mayor al máximo.

-- Usar la función en una consulta
-- La función lanzará una excepción si encuentra un salario mayor al máximo.
SELECT employee_id, first_name, max_raise2(employee_id) FROM employees;


--? Función con Row Type

-- Finalmente, reescribamos la función max_raise2 para que use variables de tipo ROWTYPE
-- para almacenar los registros completos de las tablas employees y jobs.
CREATE OR REPLACE FUNCTION max_raise2(empl_id int)
RETURNS NUMERIC(8, 2) 
AS $$

DECLARE
	selected_employee employees%ROWTYPE;
	selected_job jobs%ROWTYPE;
	
	possible_raise NUMERIC(8, 2);

BEGIN

	-- Tomar el puesto de trabajo y el salario.
	SELECT
		*
	FROM employees INTO selected_employee
	WHERE employee_id = empl_id;
	
	-- Tomar el max_salary, acorde a su job.
	SELECT
		*
	FROM jobs INTO selected_job
	WHERE job_id = selected_employee.job_id;
	
	-- Calculos.
	possible_raise = selected_job.max_salary - selected_employee.salary;
	
	-- Condiciones y Excepciones
	IF (possible_raise <= 0) THEN
		
		RAISE EXCEPTION 'Persona con salario mayor a max_salary: id:%, %', selected_employee.employee_id, selected_employee.first_name;
		--possible_raise = 0;
	
	END IF;
		
	RETURN possible_raise;

END;

$$ LANGUAGE plpgsql;