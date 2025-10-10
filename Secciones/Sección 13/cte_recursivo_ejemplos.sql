--! Ejemplos de CTE Recursivas

-- En este archivo, exploramos ejemplos prácticos de CTEs recursivas utilizando una tabla de empleados.
-- La tabla "employees" contiene información sobre empleados y sus respectivos jefes (reports_to).
-- Usaremos CTEs recursivas para navegar por la jerarquía de empleados y obtener información sobre los niveles de reporte.
SELECT * FROM employees;

-- Ejemplo básico sin CTE recursiva
-- Aquí, realizamos consultas simples para obtener empleados que reportan directamente a ciertos jefes.
SELECT * FROM employees where reports_to = 1
UNION
SELECT * FROM employees where reports_to in (2, 3)
UNION
SELECT * FROM employees where reports_to in (6, 4, 5);

-- Ejemplo de CTE recursiva para encontrar todos los empleados que reportan a un jefe específico (employee_id = 1)
-- La parte base selecciona al empleado con employee_id = 1.
WITH RECURSIVE bosses AS (

		SELECT employee_id, "name", reports_to FROM employees WHERE employee_id = 1
	UNION
		SELECT employees.employee_id, employees."name", employees.reports_to FROM employees
			INNER JOIN bosses ON bosses.employee_id = employees.reports_to
)
SELECT * FROM bosses;

-- Ejemplo de CTE recursiva con nivel de jerarquía
-- Aquí, además de obtener los empleados que reportan a un jefe específico, también calculamos el nivel de jerarquía.
-- La parte base selecciona al empleado con employee_id = 1 y asigna el nivel 0.
-- La parte recursiva incrementa el nivel en 1 para cada nivel adicional de reporte.
WITH RECURSIVE bosses AS (
  SELECT employee_id, "name", reports_to, 0 AS level
  FROM employees
  WHERE employee_id = 1

  UNION ALL

  SELECT e.employee_id, e."name", e.reports_to, b.level + 1
  FROM employees e
  JOIN bosses b ON e.reports_to = b.employee_id
)
SELECT * FROM bosses ORDER BY level;

-- Ejemplo de CTE recursiva con límite de niveles
-- Similar al ejemplo anterior, pero aquí limitamos la recursión a un máximo de 4 niveles de jerarquía.
-- Esto se logra añadiendo una condición en la parte recursiva para que solo continúe si el nivel es menor que 4.
WITH RECURSIVE bosses AS (
  SELECT employee_id, "name", reports_to, 0 AS level
  FROM employees
  WHERE employee_id = 1

  UNION ALL

  SELECT e.employee_id, e."name", e.reports_to, b.level + 1
  FROM employees e
  JOIN bosses b ON e.reports_to = b.employee_id
  WHERE b.level < 4
)
SELECT * FROM bosses ORDER BY level;

-- Ejemplo de CTE recursiva con nombre del jefe
-- En este ejemplo, además de obtener los empleados y su nivel de jerarquía, también incluimos el nombre del jefe directo de cada empleado.
-- La parte base selecciona al empleado con employee_id = 1 y obtiene su nombre de jefe (que será NULL en este caso).
-- La parte recursiva une la tabla de empleados con la CTE para obtener el nombre del jefe de cada empleado.
WITH RECURSIVE bosses AS (
  SELECT employee_id, "name", (SELECT "name" FROM employees WHERE employee_id = em1.reports_to), reports_to, 0 AS level
  FROM employees em1
  WHERE employee_id = 1

  UNION ALL

  SELECT e.employee_id, e."name", (SELECT "name" FROM employees WHERE employee_id = e.reports_to), e.reports_to, b.level + 1
  FROM employees e
  JOIN bosses b ON e.reports_to = b.employee_id
  --WHERE b.level < 2
)
SELECT * FROM bosses ORDER BY level;

-- Ejemplo de CTE recursiva con JOIN para obtener nombre del jefe
-- En este ejemplo, usamos un JOIN en la consulta final para obtener el nombre del jefe de cada empleado.
-- Esto puede ser más eficiente que usar subconsultas en la parte recursiva.
WITH RECURSIVE bosses AS (
  SELECT employee_id, "name", reports_to, 0 AS level
  FROM employees
  WHERE employee_id = 1

  UNION ALL

  SELECT e.employee_id, e."name", e.reports_to, b.level + 1
  FROM employees e
  JOIN bosses b ON e.reports_to = b.employee_id
  -- WHERE b.level < 5   -- opcional: limitar profundidad
)
SELECT b.*, m.name AS reports_to_name
FROM bosses b
LEFT JOIN employees m ON m.employee_id = b.reports_to
ORDER BY b.level, b.employee_id;
