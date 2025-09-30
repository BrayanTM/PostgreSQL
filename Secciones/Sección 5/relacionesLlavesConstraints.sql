--! LLAVES PRIMARIAS
SELECT * FROM country;

--- Agregar llave primaria
ALTER TABLE COUNTRY ADD PRIMARY KEY (CODE);

--! CHECK CONSTRAINTS
--- Agregar CHECK constraint
ALTER TABLE COUNTRY ADD CHECK (SURFACEAREA >= 0);

SELECT DISTINCT CONTINENT FROM COUNTRY;

--- Agregar CHECK constraint con lista de valores permitidos
ALTER TABLE COUNTRY
ADD CHECK (
    CONTINENT IN (
        'Asia',
        'Europe',
        'North America',
        'Africa',
        'Oceania',
        'Antarctica',
        'South America',
        'Central America'
    )
);

Asia South America North America Oceania Antarctica Africa Europe

SELECT * FROM country WHERE CODE = 'CRI';

--- Modificamos el continente de Costa Rica
UPDATE COUNTRY SET CONTINENT = 'Central America' WHERE CODE = 'CRI';

--- Eliminar CHECK constraint
ALTER TABLE country DROP CONSTRAINT country_continent_check;

--! INDICES

SELECT * FROM COUNTRY;

SELECT * FROM COUNTRY WHERE CONTINENT = 'Africa';

CREATE UNIQUE INDEX "unique_country_name" ON COUNTRY (NAME);

CREATE INDEX "index_country_continent" ON COUNTRY (CONTINENT);

--! UNIQUE INDEX - PROBLEMAS DE LA VIDA REAL

SELECT * FROM city;

SELECT *
FROM city
WHERE
    NAME = 'Jinzhou'
    AND countrycode = 'CHN'
    AND district = 'Liaoning';

CREATE UNIQUE INDEX "unique_name_countrycode_district" ON CITY (NAME, COUNTRYCODE, DISTRICT);

CREATE INDEX "index_district" ON CITY (DISTRICT);

--! LLAVES FOREANAS

ALTER TABLE CITY
ADD CONSTRAINT fk_country_code FOREIGN KEY (COUNTRYCODE) REFERENCES COUNTRY (CODE);

SELECT * FROM COUNTRY WHERE CODE = 'AFG';

-- https://gist.github.com/Klerith/0e0f5886c8f9a6f64e7de666ba493c5b
INSERT INTO
    country
VALUES (
        'AFG',
        'Afghanistan',
        'Asia',
        'Southern Asia',
        652860,
        1919,
        40000000,
        62,
        69000000,
        NULL,
        'Afghanistan',
        'Totalitarian',
        NULL,
        NULL,
        'AF'
    );

ALTER TABLE countrylanguage
ADD CONSTRAINT fk_country_code FOREIGN KEY (COUNTRYCODE) REFERENCES COUNTRY (CODE);


--! ON DELETE - CASCADE
SELECT * FROM country WHERE CODE = 'AFG';

SELECT * FROM city WHERE COUNTRYCODE = 'AFG';

SELECT * FROM countrylanguage WHERE COUNTRYCODE = 'AFG';

DELETE FROM country WHERE CODE = 'AFG';