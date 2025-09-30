-- 1. Crear una llave primaria en city (id)

SELECT * FROM city;

ALTER TABLE city ADD PRIMARY KEY (ID);

-- 2. Crear un check en population, para que no soporte negativos
ALTER TABLE CITY ADD CHECK (POPULATION >= 0);

-- 3. Crear una llave primaria compuesta en "countrylanguage"
-- los campos a usar como llave compuesta son countrycode y language

SELECT * FROM COUNTRYLANGUAGE;

ALTER TABLE countrylanguage ADD PRIMARY KEY (COUNTRYCODE, LANGUAGE);

-- 4. Crear check en percentage,
-- Para que no permita negativos ni números superiores a 100

SELECT * FROM COUNTRYLANGUAGE;

ALTER TABLE countrylanguage
ADD CHECK (
    (PERCENTAGE >= 0)
    AND (PERCENTAGE <= 100)
);