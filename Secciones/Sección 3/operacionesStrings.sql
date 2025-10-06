-- Active: 1756776371176@@127.0.0.1@5432@course-db
--! Operaciones básicas con cadenas
SELECT
	ID, 
	UPPER(NAME) AS "UPPER_NAME", 
	LOWER(NAME) AS "LOWER_NAME", 
	LENGTH(NAME) AS "LENGHT",
	(20*2) AS "CONSTANTE",
	'*' || ID || '-' || NAME || '*' AS BARCODE,
	CONCAT('*', ID, '-', NAME, '*') AS BARCODE_2,
	NAME
FROM
	USERS;

--! Substrings y Position

SELECT
    NAME,
    SUBSTRING(NAME, 0, POSITION(' ' IN NAME)) AS "FIRST NAME",
    SUBSTRING(NAME, POSITION(' ' IN NAME) + 1) AS "LAST NAME",
    TRIM(SUBSTRING(NAME, POSITION(' ' IN NAME))) AS "TRIM LAST NAME"
FROM 
    USERS;

--! Separar name en first_name y last_name

UPDATE
    USERS   
SET
    FIRST_NAME = SUBSTRING(NAME, 0, POSITION(' ' IN NAME)),
    LAST_NAME = SUBSTRING(NAME, POSITION(' ' IN NAME) + 1);

SELECT * FROM USERS;