--! Funciones Importantes
SELECT
    now(),
    CURRENT_DATE,
    current_time,
    DATE_PART('hours', NOW()) as hours,
    date_part('minutes', NOW()) as minutes,
    date_part('seconds', NOW()) as seconds,
    date_part('day', NOW()) as day,
    date_part('month', NOW()) as month,
    date_part('year', NOW()) as year;

--! Consultas sobre fechas

select *
from employees
where
    hire_date > '1998-02-05'
ORDER BY hire_date;

select
    max(hire_date) as primer_empleado,
    min(hire_date) as ultimo_empleado
from employees;

select *
from employees
where
    hire_date BETWEEN '1998-01-01' AND '2001-12-31'
ORDER BY hire_date;

--! Intervalos

select
    max(hire_date),
    max(hire_date) + INTERVAL '1 day' as mas_un_dia,
    max(hire_date) + INTERVAL '1 month' as mas_un_mes,
    max(hire_date) + INTERVAL '1 year' as mas_un_anio,
    max(hire_date) + INTERVAL '1 year 2 months 15 days' as mas_todo,
    date_part('year', now()),
    make_interval(years := 15) as intervalo_15_anios,
    make_interval(
        years => 1,
        months => 2,
        days => 15
    ) as intervalo_completo,
    make_interval(
        years => date_part('year', now())::integer
    ) as intervalo_anio_actual,
    max(hire_date) + make_interval(years := 15) as fecha_mas_15_anios
from employees;

--! Diferencia entre fechas y actualizaciones

SELECT
    hire_date,
    make_interval(
        years => 2025 - extract(
            years
            from hire_date
        )::integer
    ) as intervalo_hasta_2025,
    make_interval(
        years => date_part('year', now())::integer - extract(
            years
            from hire_date
        )::integer
    ) as intervalo_hasta_anio_actual
FROM employees
ORDER BY hire_date desc;

--! Actualizar fechas
select hire_date from employees;

select 
    hire_date, 
    hire_date + INTERVAL '25 years' as nueva_fecha
from employees
ORDER BY hire_date DESC;

update employees
set hire_date = hire_date + INTERVAL '25 years';

--! Clausula Case - Then

SELECT 
    first_name,
    last_name,
    hire_date,
    CASE
        WHEN hire_date > now() - INTERVAL '1 year' THEN 'Rango A'
        WHEN hire_date > now() - INTERVAL '3 year' THEN 'Rango B'
        WHEN hire_date > now() - INTERVAL '6 year' THEN 'Rango C'
        ELSE 'Rango D'
    END as rango_antiguedad
FROM employees
ORDER BY hire_date DESC;

SELECT 
    first_name,
    last_name,
    hire_date,
    CASE
        WHEN hire_date > now() - INTERVAL '1 year' THEN '1 año o menos'
        WHEN hire_date > now() - INTERVAL '3 year' THEN '1 a 3 años'
        WHEN hire_date > now() - INTERVAL '6 year' THEN '3 a 6 años'
        ELSE 'Más de 6 años'
    END as rango_antiguedad
FROM employees
ORDER BY hire_date DESC;