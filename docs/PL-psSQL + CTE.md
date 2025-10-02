# PL/pgSQL + CTE

PL/pgSQL es un lenguaje procedural para PostgreSQL que amplía la funcionalidad de SQL, permitiendo crear funciones, procedimientos almacenados y disparadores con lógica compleja, lo que ofrece más flexibilidad y control en el servidor de base de datos.

En SQL, una CTE (Common Table Expression o Expresión de Tabla Común) es un conjunto de resultados temporal con nombre al que puedes referenciar dentro de una sola sentencia SQL (SELECT, INSERT, UPDATE, o DELETE). Se definen con la palabra clave WITH y actúan como una vista temporal que existe solo durante la ejecución de la consulta principal, ayudando a simplificar y organizar consultas complejas al dividir la lógica en bloques más pequeños y reutilizables. 

## Funciones Personalizadas
[Documentación Oficial](https://www.postgresql.org/docs/current/sql-createfunction.html)

### Sintaxis General:

```sql
CREATE [OR REPLACE] FUNCTION
function_name([arguments type])
RETURNS return_datatype as $$
DECLARE
< Declaración de variables >
BEGIN
< Cuerpo de la función >
RETURN < Valor >
END; LANGUAGE plpgsql;
```

### Ejemplo:

```sql
CREATE OR REPLACE FUNCTION
greet_employee( emp_name varchar )
RETURNS varchar
AS $$
BEGIN
RETURN 'Hola ' || emp_name;
END;
$$
LANGUAGEplpgsql;

select greet_employee('Fernando');
```

## Common Table Expression (CTE)
[Documentación Oficial](https://www.postgresql.org/docs/current/queries-with.html)

```sql
with cte_name as (
select <campos> from <tabla>....
), [cte_name_2] as ()...
select * from cte_name;
```

### Recursivo:

```sql
-- Nombre de la tabla en memoria
-- campos que vamos a tener
WITH RECURSIVE countdown( val ) as (
-- initialización => el primer nivel,
o valores iniciales
-- values(5)
select 10 as val
UNION
-- Query recursivo
select val - 1 from countdown where
val > 1
)
-- Select de los campos
select * from countdown;
```

## Procedimientos Almacenados
[Documentación Oficial](https://www.postgresql.org/docs/current/sql-createprocedure.html)

```sql
CREATE OR REPLACE PROCEDURE
proc_name ( [args type] ) AS
$$
DECLARE
-- variables
BEGIN
-- cuerpo
END;
$$ LANGUAGE plpgsql;

call proc_name( 'valores' );
```

## Triggers
[Documentación Oficial](https://www.postgresql.org/docs/current/sql-createtrigger.html)

```sql
create or REPLACE TRIGGER <name>
AFTER UPDATE on "user"
FOR EACH ROW
—Opcional when
WHEN (OLD.field IS DISTINCT FROM NEW.field)
— Procedimiento/Función a ejecutar
EXECUTE FUNCTION create_session_log();

create or REPLACE FUNCTION <name>()
RETURNS TRIGGER as $$
BEGIN
— Cuerpo de la función
return NEW;
END;
$$ LANGUAGE plpgsql;
```

## PgCrypto
[Documentación Oficial](https://www.postgresql.org/docs/current/pgcrypto.html)

```sql
CREATE EXTENSION pgcrypto;
insert into "user" (username, password)
values(
'melissa',
crypt( '123456', gen_salt('bf') )
);

select count(*) from "user"
where username='fernando' and
password = crypt('123456', password);
```