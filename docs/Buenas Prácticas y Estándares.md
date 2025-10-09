# 📚 Buenas Prácticas y Estándares en PostgreSQL

> Guía completa para diseñar bases de datos robustas, escalables y mantenibles

---

## 🎯 Características de un Buen Diseño

### 1. ⚡ Minimizar la Redundancia
- ✅ Evitar data duplicada
- ✅ Aplicar normalización adecuada
- ✅ Mantener la integridad referencial

### 2. 🛡️ Proteger la Precisión
- ✅ No permitir basura (garbage data)
- ✅ Validar datos en la base de datos
- ✅ Usar constraints y checks

### 3. 🌐 Ser Accesible
- ✅ Mantener alta disponibilidad
- ✅ Optimizar rendimiento
- ✅ Facilitar el mantenimiento

### 4. ✨ Cumplir las Expectativas
- ✅ La base de datos debe cubrir las necesidades del negocio
- ✅ Ser flexible para cambios futuros
- ✅ Escalar según demanda

---

## 🔍 Determinar los Objetivos

| Paso | Descripción |
|------|-------------|
| 🔎 **Investigar** | Buscar diseños similares y mejores prácticas |
| 👥 **Involucrar** | Traer a las partes interesadas al proceso |
| 📖 **Aprender** | Empápate del tema y dominio del negocio |

---

## 📋 Principios Fundamentales

### 🏗️ Diseño y Arquitectura
- ✅ **Mantenla simple** - KISS (Keep It Simple, Stupid)
- ✅ **Usa estandarización** - Convenciones consistentes
- ✅ **Considera futuras modificaciones** - Diseño flexible
- ✅ **Mantén la deuda técnica a raya** - Refactoriza cuando sea necesario
- ✅ **Normalizar la data** - Tercera forma normal (3NF) como mínimo
- ✅ **Diseña a largo plazo** - Piensa en 5+ años

### 📝 Documentación y Pruebas
- ✅ **Crea documentación y diagramas** - ERD, UML
- ✅ **Prueba tu diseño** - Casos de uso reales
- ✅ **Mantén un modelado bajo versiones** - Control de cambios

### 🏷️ Nomenclatura

| ✅ Hacer | ❌ Evitar |
|----------|-----------|
| `person` | `people` o `persons` |
| `order_item` | `order-item` o `OrderItem` |
| `created_at` | `createdAt` o `fecha_creacion` |
| `user_account` | `user` (palabra reservada) |

**Reglas generales:**
- ✅ Nombres en **inglés**
- ✅ Todo en **minúsculas**
- ✅ Sin espacios, usar **guión bajo** (`_`)
- ✅ Nombres **completos**, sin abreviaturas
- ✅ Tablas en **singular** (`person`, no `persons`)
- ❌ Evitar caracteres especiales
- ❌ Evitar palabras reservadas (`user`, `table`, `create`)

### 🔧 Configuración Técnica
- ✅ **No re-inventes la rueda** - Usa características nativas de PostgreSQL
- ✅ **Usa lo que el motor te ofrece** - Triggers, functions, extensions
- ✅ **Reglas, checks, llaves, índices** - Para evitar basura
- ✅ **Mantén la privacidad como prioridad** - GDPR, seguridad
- ✅ **Mantén la BD en su propio servidor** - Separación de concerns
- ✅ **Establece el tipo apropiado y precisión adecuada** - `VARCHAR(50)` vs `TEXT`
- ✅ **No confíes en identificadores de terceros** - Usa tus propias PKs
- ✅ **Define las llaves foráneas y relaciones** - Integridad referencial
- ✅ **Si el esquema es muy grande, particiónalo** - Schemas lógicos

---

## 💡 Ideas Clave para Recordar

| 💭 Principio | 📌 Explicación |
|--------------|----------------|
| **Longevidad** | Los nombres de tablas y campos vivirán más que las aplicaciones |
| **Contratos** | Los nombres son contratos entre sistemas |
| **Jerarquía** | La base de datos gobierna sobre los demás componentes |

---

## 🔤 Convenciones de Nomenclatura

### 📊 Relaciones en Singular

**✅ Por qué usar singular:**

1. **Relaciones 1:1** - ¿Cómo plural si solo hay un registro?
2. **Palabras sin plural** - En inglés: `fish`, `species`, `series`
3. **Compatibilidad** - Frameworks modernos siguen esta convención
4. **Semántica clara** - `SELECT * FROM person WHERE id = 1` (una persona)

```sql
-- ✅ CORRECTO
CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE order (
    id SERIAL PRIMARY KEY,
    person_id INTEGER REFERENCES person(id)
);

-- ❌ EVITAR
CREATE TABLE persons (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
```

---

## 🎯 Nombrado Explícito

### Comparación de Estilos

| Contexto | ❌ Malo | ⚠️ Regular | ✅ Bueno |
|----------|---------|-----------|----------|
| Primary Key | `id` | `id` | `person_id` |
| Foreign Key | `team` | `team_id` | `team_id` |
| Índice | `idx_1` | `name_idx` | `person_idx_first_name_last_name` |
| Constraint | `pk_1` | `person_pk` | `person_pkey` |

### 🔑 Llaves Primarias y Foráneas

```sql
-- ✅ EJEMPLO COMPLETO
CREATE TABLE team (
    team_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person (
    person_id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE team_member (
    team_id BIGINT NOT NULL REFERENCES team(team_id),
    person_id BIGINT NOT NULL REFERENCES person(person_id),
    role VARCHAR(50),
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT team_member_pkey PRIMARY KEY (team_id, person_id)
);
```

### 📇 Índices Explícitos

```sql
-- ✅ Nombres descriptivos de índices
CREATE INDEX person_idx_first_name_last_name 
    ON person(first_name, last_name);

CREATE INDEX person_idx_email 
    ON person(email);

CREATE INDEX order_idx_created_at 
    ON order(created_at DESC);

-- Índices con condiciones
CREATE INDEX active_user_idx_email 
    ON user_account(email) 
    WHERE is_active = true;
```

---

## 📚 Recursos Adicionales

- 📖 [Documentación oficial de PostgreSQL](https://www.postgresql.org/docs/)
- 🎨 [Guía de estilo SQL](https://www.sqlstyle.guide/)
- 🔧 [PostgreSQL Wiki - Don't Do This](https://wiki.postgresql.org/wiki/Don't_Do_This)