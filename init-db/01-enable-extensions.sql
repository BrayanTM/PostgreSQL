-- Habilitar extensiones para trabajar con UUIDs
-- Este script se ejecuta automáticamente cuando se inicializa el contenedor de PostgreSQL

-- Extensión uuid-ossp: Proporciona funciones para generar UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Extensión pgcrypto: Alternativa moderna para generar UUIDs (incluye gen_random_uuid())
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Mostrar las extensiones instaladas
SELECT extname, extversion FROM pg_extension WHERE extname IN ('uuid-ossp', 'pgcrypto');

-- Ejemplos de uso:
-- Usando uuid-ossp:
-- SELECT uuid_generate_v1();    -- UUID basado en MAC y timestamp
-- SELECT uuid_generate_v4();    -- UUID aleatorio (recomendado)

-- Usando pgcrypto (PostgreSQL 13+):
-- SELECT gen_random_uuid();     -- UUID aleatorio (función nativa moderna)