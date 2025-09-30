-- Tarea con countryLanguage

-- Crear la tabla de language

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS language_code_seq;

-- Table Definition
CREATE TABLE "public"."language" (
    "code" int4 NOT NULL DEFAULT nextval('language_code_seq'::regclass),
    "name" text NOT NULL,
    PRIMARY KEY ("code")
);

-- Crear una columna en countrylanguage
ALTER TABLE countrylanguage ADD COLUMN languagecode varchar(3);

-- Empezar con el select para confirmar lo que vamos a actualizar

SELECT * FROM language;

SELECT DISTINCT LANGUAGE FROM countrylanguage ORDER BY LANGUAGE;

SELECT a.LANGUAGE, (
        SELECT CODE
        FROM language b
        WHERE
            a.LANGUAGE = b.NAME
    )
FROM countrylanguage a;

-- Actualizar todos los registros

INSERT INTO
    language (NAME)
SELECT DISTINCT
    LANGUAGE
FROM countrylanguage
ORDER BY LANGUAGE;

UPDATE countrylanguage a
SET
    languagecode = (
        SELECT CODE
        FROM language b
        WHERE
            a.LANGUAGE = b.NAME
    );

-- Cambiar tipo de dato en countrylanguage - languagecode por int4

ALTER TABLE countrylanguage
ALTER COLUMN languagecode TYPE INT4 USING languagecode::INT4;

-- Crear el forening key y constraints de no nulo el language_code

ALTER TABLE "countrylanguage" ADD FOREIGN KEY ("languagecode") REFERENCES "language"("code");

-- Revisar lo creado
SELECT * FROM countrylanguage;