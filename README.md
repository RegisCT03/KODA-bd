# KODA — Database Schema

Este repositorio contiene las definiciones de esquema, tipos e índices para la base de datos de **KODA**, el entrenador de velocidad de tipeo para programadores. La base de datos está construida sobre **PostgreSQL** y gestionada mediante **Supabase**.

---

## Stack Tecnológico

- **Motor:** PostgreSQL (Supabase).
- **ORM:** Prisma 5.
- **Infraestructura:** Render (Backend) y Supabase (Database).

---

## Estructura de Datos

El diseño se centra en la integridad referencial y la eficiencia en las consultas de rendimiento:

### Tablas Principales
- **`User`**: Almacena las credenciales (email único y contraseña hasheada) y la fecha de creación del perfil.
- **`Language`**: Catálogo de lenguajes de programación disponibles (Python, TypeScript, JavaScript, Java, etc.).
- **`Snippet`**: Fragmentos de código para practicar, incluyendo nivel de dificultad y etiquetas.
- **`TypingSession`**: Registro de métricas de cada intento (WPM, CPM, precisión, errores y teclas difíciles).

### Enums
- **`Difficulty`**: `EASY`, `MEDIUM`, `HARD`.
- **`SessionStatus`**: `COMPLETED`, `INVALID`, `INCOMPLETE`.

---

## Organización de Archivos SQL

Para facilitar el despliegue manual o la referencia, el esquema se divide en:
1.  **`01_schema.sql`**: Contiene la creación de tipos ENUM y las tablas con sus restricciones de integridad (`PRIMARY KEY`, `FOREIGN KEY`).
2.  **`02_indexes.sql`**: Definición de índices para optimizar búsquedas por email y filtrado de sesiones por usuario, fecha y estado.

---

## Configuración del Backend

Para la conexión desde el servidor de Node.js, asegúrate de configurar las variables de entorno correctamente:

```env
# URL con Connection Pooling
DATABASE_URL="postgresql://user:password@host:puerto/postgres?pgbouncer=true"

# URL Directa
DIRECT_URL="postgresql://user:password@host:puerto/postgres"
```

---

## Integridad y Seguridad
- Borrado en Cascada: Al eliminar un usuario, todas sus sesiones de tipeo asociadas se eliminan automáticamente (ON DELETE CASCADE).
- Protección de Datos: No se permiten lenguajes duplicados ni slugs repetidos en la tabla de lenguajes.
- Archivado: Las sesiones marcadas como archived permiten optimizar las consultas de progreso recientes sin perder datos históricos.