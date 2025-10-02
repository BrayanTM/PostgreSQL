# Bases de datos con PostgreSQL

# Tipos de Comandos SQL
Los comandos SQL se agrupan en cinco tipos principales: **Lenguaje de Definición de Datos (DDL)** para crear y modificar la estructura de la base de datos; **Lenguaje de Manipulación de Datos (DML)** para insertar, actualizar y eliminar datos; **Lenguaje de Consulta de Datos (DQL)** para recuperar información; **Lenguaje de Control de Datos (DCL)** para administrar permisos y acceso; y **Lenguaje de Control de Transacciones (TCL)** para gestionar transacciones y garantizar la integridad de los datos. 

**1. Lenguaje de Definición de Datos (DDL)**
**Función:**
Se utiliza para definir y modificar la estructura de los objetos de la base de datos. 
Comandos principales:
**CREATE:** Para crear tablas, vistas u otros objetos.
**ALTER:** Para cambiar la estructura de objetos existentes.
**DROP:** Para eliminar objetos de la base de datos. 

**2. Lenguaje de Manipulación de Datos (DML)** 
**Función:**
Permite trabajar con los datos dentro de las tablas. 
Comandos principales:
**INSERT INTO:** Para agregar nuevos registros a una tabla.
**UPDATE:** Para modificar los datos de registros existentes.
**DELETE:** Para eliminar registros de una tabla. 

**3. Lenguaje de Consulta de Datos (DQL)**
**Función:**
Se enfoca en la recuperación de información de la base de datos. 
Comando principal:
**SELECT:** Para consultar y extraer datos de una o varias tablas según criterios definidos. 

**4. Lenguaje de Control de Datos (DCL)**
**Función:**
Controla el acceso y los permisos de los usuarios a la base de datos, asegurando su seguridad. 
Comandos principales:
**GRANT:** Para otorgar permisos a un usuario o rol.
**REVOKE:** Para quitar permisos previamente concedidos. 

**5. Lenguaje de Control de Transacciones (TCL)** 
**Función:**
Gestiona las transacciones para garantizar la consistencia y la integridad de la base de datos. 
Comandos principales:
**COMMIT:** Guarda permanentemente todos los cambios realizados en una transacción.
**ROLLBACK:** Deshace los cambios realizados en la transacción actual, revirtiendo la base de datos a su estado anterior.
**SAVEPOINT:** Establece un punto dentro de una transacción al que se puede volver más tarde. 