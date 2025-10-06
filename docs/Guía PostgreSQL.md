# Guía PostgreSQL

## Tipos de Datos Generales
[Documentación Oficial](https://www.postgresql.org/docs/current/datatype.html)

|Tipo|Alias|Descripción|
|:---:|:---:|:---:|
|bigint|int8|Entero de 8 bytes con el signo|
|bit [ (n) ]||Cadena de bits de longitud fija|
|bit varying [ (n) ]|varbit [ (n) ]|Cadena de bits de longitud variable|
|boolean|bool|Booleano lógico (verdadero/falso)|
|character varying [ (n) ]|varchar [ (n) ]|Cadena de caracteres de longitud variable|
|date||Fecha del calendario (año, nes día)|
|integer|int, int4|Entero de cuatro bytes con signo|
|json||Datos JSON textuales|
|money||Cantidad en moneda|
|numeric [ (p, s) ]|decimal [ (p, s) ]|Numérico exacto de precisión seleccionable|
|smallint|int2|Entero de dos bytes con signo|
|smallserial|serial2|Entero de dos bytes autoincrementable|
|serial|serial4|Entero de cuatro bytes autoincrementable|
|text||Cadena de caracteres de longitud variable|
|time [ (p) ][without time zone]||Hora del día (sin zona horaria)|
|time [ (p) ] whit time zone|timetz|Hora del día, incluida la zona horaria|
|timestamp [ (p) ][whithout time zone]||Fehca y hora, (sin zona horaria)|
|timestamp [ (p) ] whith time zone|timestamptz|Fecha y hora, incluida la zona horaria|
|uuid||Identificador único universal|
|xml||Datos XML|

***
## Operadores de Strings y Funciones
[Documentación Oficial](https://www.postgresql.org/docs/9.1/functions-string.html)

|Operador/Función|Descripción|
|:---:|:---:|
|\|\||Concatena dos o más strings|
|CONCAT( )|Une dos o más strings|
|LOWER( )|Resultado en minúsculas|
|UPPER( )|Resultado en mayúsculas|
|LENGTH( )|Número de caracteres del string|
|POSITION('term' in field)|Busca 'term' en el campo y retorna el id|
|TRIM(text)|Remueve los espacios iniciales y finales del string (ltrim, rtrim)|

***
## Operadores Matemáticos y Funciones
[Documentación Oficial](https://www.postgresql.org/docs/9.5/functions-math.html)

|Operador/Función|Descripción|
|:--:|:--:|
|+|Sumar|
|-|Restar|
|*|Multiplicar|
|/|Dividir (divisiones entre enteros cortan el resultado)|
|%|Resultado de la división|
|ROUND(v,p)|Redondea el valor y presición decimal|

***
## Operadores de Comparación
[Documentación Oficial](https://www.postgresql.org/docs/current/functions-comparison.html)

|Operador/Función|Descripción|
|:--:|:--:|
|=|¿Son los valores iguales?|
|>|¿Es el valor de la izquierda más grande que el de la derecha?|
|<|¿Es el valor de la izquierda más pequeño que el de la derecha?|
|>=|¿Es el valor de la izquierda mayor o giual que el de la derecha?|
|<=|¿Es el valor de la izquierda menor o giual que el de la derecha?|
|IN|¿El valor se encuentra en la lista?|
|NOT IN|¿El valor no se encuentra en la lista?|
|<>|¿Los valores no son iguales?|
|!=|¿Los valores no son iguales?|
|BETWEEN|¿El valor se encuentra entre estos dos valores?|
|NOT BETWEEN|¿El valor no se encuentra entre estos dos valores?|
|IS NULL|Realiza la verificación si el resultado o campo es nulo|
|LIKE|El término de búsqueda contiene un patrón específico|
|NOT LIKE|El término de búsqueda no contiene un patrón específico|

***
## Operadores Lógicos
[Documentación Oficial](https://www.postgresql.org/docs/current/functions-logical.html)

|Operador|Descripción|
|:-:|:-:|
|AND|Ambas condiciones se deben de cumplir|
|OR|Una de las condiciones se tiene que cumplir|
|NOT|Depende de donde se use, pero en general es una negación|

### Tabla Lógica


|a|b|a AND b|a OR b|
|:-:|:-:|:-:|:-:|
|TRUE|TRUE|TRUE|TRUE|
|TRUE|FALSE|FALSE|TRUE|
|TRUE|NULL|NULL|TRUE|
|FALSE|FALSE|FALSE|FALSE|
|FALSE|NULL|FALSE|NULL|
|NULL|NULL|NULL|NULL|

### Tabla Lógica de NOT
|a|NOT a|
|:-:|:-:|
|TRUE|FALSE|
|FALSE|TRUE|
|NULL|NULL|

***
## Primary Keys Automáticas

|Tipo|Descripción|
|:-:|:-:|
|SERIAL|Serie de valores numéricos correlativos|
|SEQUENCE|Secuencia personalizada única|
|gen_random_uuid( )|Secuencia personalizada única|

### Ejemplo de SERIAL Primary Key

```sql
CREATE TABLE books (
id SERIAL PRIMARY KEY,
title VARCHAR(100) NOT NULL,
primary_author VARCHAR(100) NULL
);
```

### Ejemplo de SEQUENCE Primary Key

```sql
CREATE SEQUENCE books_sequence
start 2
increment 2;

INSERT INTO books
(id, title)
VALUES
( nextval('books_sequence'), 'TheHobbit' );
```

### En Definición de Tabla

```sql
CREATE TABLE Students (
id bigint DEFAULT nextval('integer_id_seq')
PRIMARY KEY,
name VARCHAR(200) not NULL
);
CREATE TABLE Students (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
name VARCHAR(200) not NULL
);
CREATE EXTENSION IF NOT EXISTS 'uuid-ossp';
DROP EXTENSION 'uuid-ossp';
```

***
## Ejemplos de Cláusulas

### BETWEEN

```sql
SELECT * FROM 'users'
WHERE 'id' BETWEEN 2 AND 4;
```

### CASE

```sql
SELECT 'name', 'salary',
CASE
WHEN 'salary' > 6000 THEN 'Salario mayor a 6000$'
WHEN 'salary' > 4000 THEN 'Salario mayor a 4000$'
WHEN 'salary' >= 2000 THEN 'Salario mayor a 2000$'
ELSE 'Salario menor a 2000$'
END AS 'Salary information'
FROM 'users';
```

### Comentarios

```sql
-- Single-line comment
/*
Multi-line
comment
*/
```

## Comandos Comunes

### Crear Base de Datos

```sql
CREATE DATABASE “database_name";

CREATE DATABASE IF NOT EXISTS 'productsDB';
```

### Crear Tabla

```sql
CREATE TABLE "users" (
id SERIAL,
name VARCHAR(100) NOT NULL,
role VARCHAR(15) NOT NULL,
PRIMARY KEY (id)
);
```

### Crear Vista y Destruir Vista

```sql
CREATE OR REPLACE [MATERIALIZED] VIEW
"v_spain_users" AS
SELECT 'name', 'email' FROM 'users'
WHERE 'country' = 'Spain';

DROP [MATERIALIZED]
 VIEW "v_spawn_users";
```

### Eliminar Registros

```sql
DELETE FROM 'table_name'
WHERE 'column_name' = some_value;
```

### Inserciones

```sql
INSERT INTO 'table_name'
('column1', 'column2', 'column3', ...)
VALUES
('value1', 'value2', 'value3', ...);

-- Múltiples
INSERT INTO 'table_name'
('column1', 'column2', 'column3', …)
VALUES
('value1', 'value2', 'value3', ...),
('value1', 'value2', 'value3', ...),
('value1', 'value2', 'value3', ...),
...;
```

### Actualizar Registros

```sql
UPDATE 'users'
SET
'name' = 'Christopher' ,
'role' = 'admin'
WHERE 'id' = 2;
```

### GROUP BY y COUNT

```sql
SELECT COUNT(name) AS user_count, 'country'
FROM 'users2'
GROUP BY 'country'
ORDER BY user_count DESC;
```

### LIKE Statments

```sql
SELECT * FROM “users"
-- Nombre inicie con J mayúscula
WHERE 'name' LIKE 'J%';
-- Nombre inicie con Jo
WHERE 'name' LIKE 'Jo%';
-- Nombre termine con hn
WHERE 'name' LIKE '%hn';
-- Nombre tenga 3 letras y las últimas
2
-- tienen que ser "om"
WHERE 'name' LIKE '_om'; // Tom
-- Puede iniciar con cualquier letra
-- seguido de "om" y cualquier cosa
después
WHERE 'name' LIKE '_om%'; // Tomas
```

### LIMIT y OFFSET

```sql
SELECT * FROM 'users'
LIMIT 5
OFFSET 10;
```

### ORDER BY

```sql
SELECT 'column1', "column2", ...
FROM 'table_name'
ORDER BY 'column1', ... ASC|DESC;
```

### SELECT DISTINCT

```sql
SELECT DISTINCT 'country'
FROM 'users';
```

### Contar registros en tabla y HAVING

```sql
select count(*) from photos
select count(*), 'column'
from 'table'
GROUP by 'column'
HAVING count(*) > 3
```

***
## Funciones de Agregación
[Documentación Oficial](https://www.postgresql.org/docs/9.5/functions-aggregate.html)

|Función|Descripción|
|:-:|:-:|
|ARRAY_AGG(expression)|Valores de entrada, incluidos nulos, concatenados en una matriz|
|AVG(expression)|El promedio (media aritmética) de todos los valores de entrada no nulos|
|COUNT(*)|Número de filas de entrada|
|COUNT(expression)|Número de filas de entrada para las que el valor de expresión no es nulo|
|JSON_AGG(expression)|Agrega valores, incluidos valores nulos, como una matriz JSON|
|MAX(expression)|Valor máximo de expresión en todos los valores de entrada no nulos|
|MIN(expression)|Valor mínimo de expresión en todos los valores de entrada no nulos|
|STRING_AGG(expression, delimiter)|Valores de entrada no nulos concatenados en una cadena, separados por delimitadores|
|SUM(expression)|Suma de expresión en todos los valores de entrada no nulos|

***
## Funciones Condicionales
[Documentación Oficial](https://www.postgresql.org/docs/current/functions-conditional.html)

|Función|Descripción|
|:-:|:-:|
|COALESCE(any repeated)|Devuelve el primero de sus argumentos que no es nulo|
|GREATEST(any repeated)|Devuelve el valor más grande de una lista de cualquier número de expresiones|
|LEAST(any repeated)|Devuelve el valor más pequeño de una lista de cualquier número de expresiones|
|NULLIF(value1 any, value2 any)|Devuelve un valor nulo si el valor1 es igual a valor2, de lo contrario, devuelve valor1|

***
## JOINS - Uniones de Tablas

|Visualización|SQL Query|
|:-:|:-:|
|![0e95137253d4a8877f2afdcd583d297f.png](:/25f08df1a4a346c3a0559b13eae4e492)|<pre><code>SELECT * FROM table_a A</code><br><code>JOIN table_b B</code><br><code>ON A.key = B.key</code></pre>|
|![148715de90478a3d3d4ba04fb7622188.png](:/17f68f54582b4ac9a341894dc89ec8f0)|<pre><code>SELECT * FROM table_a A</code><br><code>LEFT JOIN table_b B</code><br><code>ON A.key = B.key</code></pre>|
|![423e09002884e1592538c1825660c28d.png](:/1cb26b07c4c54eef90c75d0515ca934b)|<pre><code>SELECT * FROM table_a A</code><br><code>RIGHT JOIN table_b B</code><br><code>ON A.key = B.key</code></pre>|
|![211504244758af04a37824a521fc3950.png](:/ef4da6fa23ea466386f82f0baef42505)|<pre><code>SELECT * FROM table_a A</code><br><code>FULL OUTER JOIN table_b B</code><br><code>ON A.key = B.key<code></pre>|
|![9a808d5738ac4348cc14bcb229b759ec.png](:/96d6f6a99b134693bee5323c620cb312)|<pre><code>SELECT *</code><br><code>FROM table_a A</code><br><code>LEFT JOIN table_b B ON</code><br><code>A.key = B.key</code><br><code>WHERE B.key IS NULL</code><pre>|
|![6e6bf4d4d78e64d92546b7b77f16d19b.png](:/9276f9615adc4b369a1dec5107c01113)|<pre><code>SELECT *</code><br><code>FROM table_a A</code><br><code>RIGHT JOIN table_b B</code><br><code>ON A.key = B.key</code><br><code>WHERE A.key IS NULL</code></pre>|
|![3c2c9e5a16cfeb8a84d06d2705ec3b89.png](:/9405a7fe33ef491082300472f5ce5549)|<pre><code>SELECT * FROM table_a A</code><br><code>FULL OUTER JOIN table_b B</code><br><code>ON A.key = B.key</code><br><code>WHERE B.key IS NULL OR</code><br><code>A.key IS NULL</code></pre>|