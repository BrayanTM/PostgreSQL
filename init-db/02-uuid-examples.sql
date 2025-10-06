-- Ejemplos prácticos de uso de UUIDs en PostgreSQL
-- Este archivo contiene ejemplos de cómo implementar UUIDs en tus tablas

-- Ejemplo 1: Tabla con UUID como clave primaria usando uuid-ossp
CREATE TABLE IF NOT EXISTS usuarios_uuid (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Ejemplo 2: Tabla con UUID como clave primaria usando pgcrypto (PostgreSQL 13+)
CREATE TABLE IF NOT EXISTS productos_uuid (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    categoria_id UUID,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Ejemplo 3: Insertar datos con UUIDs automáticos
INSERT INTO usuarios_uuid (nombre, email) VALUES 
    ('Juan Pérez', 'juan@email.com'),
    ('María García', 'maria@email.com'),
    ('Carlos López', 'carlos@email.com');

-- Ejemplo 4: Insertar datos con UUID específico
INSERT INTO productos_uuid (id, nombre, precio) VALUES 
    (uuid_generate_v4(), 'Laptop Dell', 999.99),
    (gen_random_uuid(), 'Mouse Logitech', 29.99);

-- Ejemplo 5: Consultas con UUIDs
-- SELECT * FROM usuarios_uuid WHERE id = 'uuid-aqui';
-- SELECT * FROM productos_uuid ORDER BY created_at DESC;

-- Funciones útiles para UUIDs:
-- uuid_generate_v1()    - UUID basado en MAC y timestamp
-- uuid_generate_v4()    - UUID completamente aleatorio (recomendado)
-- gen_random_uuid()     - Función nativa moderna (PostgreSQL 13+)
-- uuid_nil()            - UUID nulo (00000000-0000-0000-0000-000000000000)