# 🏗️ Arquitectura del Proyecto Empower

## 📐 Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────────────────────┐
│                         USUARIO                                  │
│                    (Navegador Web)                               │
│                   http://localhost                               │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                   CONTENEDOR FRONTEND                            │
│                   (empower_frontend)                             │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐    │
│  │         Nginx Web Server (Puerto 80)                    │    │
│  │                                                          │    │
│  │  ┌──────────────────────────────────────────────┐      │    │
│  │  │    Flutter Web App (build/web)               │      │    │
│  │  │                                               │      │    │
│  │  │  • main.dart                                  │      │    │
│  │  │  • login_page.dart                            │      │    │
│  │  │  • registro_page.dart                         │      │    │
│  │  │  • inicio_page.dart                           │      │    │
│  │  │  • perfil_page.dart                           │      │    │
│  │  │                                               │      │    │
│  │  │  Peticiones HTTP ──────────────────────┐     │      │    │
│  │  └───────────────────────────────────────│──────┘      │    │
│  └────────────────────────────────────────────│─────────────┘    │
└───────────────────────────────────────────────│──────────────────┘
                                                │
                         Proxy inverso          │
                         /empower/              │
                                                │
                                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                   CONTENEDOR BACKEND                             │
│                   (empower_backend)                              │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐    │
│  │     Apache Web Server + PHP 8.2 (Puerto 8080)          │    │
│  │                                                          │    │
│  │  ┌──────────────────────────────────────────────┐      │    │
│  │  │    API REST PHP                              │      │    │
│  │  │                                               │      │    │
│  │  │  /empower/login.php                          │      │    │
│  │  │    • Autenticación de usuarios               │      │    │
│  │  │    • POST: {correo, contrasena}              │      │    │
│  │  │                                               │      │    │
│  │  │  /empower/register.php                       │      │    │
│  │  │    • Registro de nuevos usuarios             │      │    │
│  │  │    • POST: {nombre, apellidos, ...}          │      │    │
│  │  │                                               │      │    │
│  │  │  /empower/get_puntos.php                     │      │    │
│  │  │    • Consulta de puntos de reciclaje         │      │    │
│  │  │    • POST: {correo}                          │      │    │
│  │  │                                               │      │    │
│  │  │  config.php                                  │      │    │
│  │  │    • Configuración de conexión a BD          │      │    │
│  │  │                                               │      │    │
│  │  │  Consultas SQL ────────────────────────┐    │      │    │
│  │  └───────────────────────────────────────│─────┘      │    │
│  └────────────────────────────────────────────│─────────────┘    │
└───────────────────────────────────────────────│──────────────────┘
                                                │
                                                │ MySQL Protocol
                                                │ (mysqli/PDO)
                                                │
                                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                   CONTENEDOR DATABASE                            │
│                   (empower_mysql)                                │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐    │
│  │         MySQL 8.0 Server (Puerto 3306)                  │    │
│  │                                                          │    │
│  │  ┌──────────────────────────────────────────────┐      │    │
│  │  │    Base de Datos: empower_db                 │      │    │
│  │  │                                               │      │    │
│  │  │  ┌──────────────────────────────────┐        │      │    │
│  │  │  │  Tabla: usuarios                 │        │      │    │
│  │  │  │  • id (PK)                       │        │      │    │
│  │  │  │  • nombre                        │        │      │    │
│  │  │  │  • apellidos                     │        │      │    │
│  │  │  │  • escuela                       │        │      │    │
│  │  │  │  • correo (UNIQUE)               │        │      │    │
│  │  │  │  • contrasena (hashed)           │        │      │    │
│  │  │  │  • fecha_registro                │        │      │    │
│  │  │  └──────────────────────────────────┘        │      │    │
│  │  │                                               │      │    │
│  │  │  ┌──────────────────────────────────┐        │      │    │
│  │  │  │  Tabla: puntos                   │        │      │    │
│  │  │  │  • id (PK)                       │        │      │    │
│  │  │  │  • usuario_id (FK)               │        │      │    │
│  │  │  │  • plastico (INT)                │        │      │    │
│  │  │  │  • carton (INT)                  │        │      │    │
│  │  │  │  • aluminio (INT)                │        │      │    │
│  │  │  │  • total (INT)                   │        │      │    │
│  │  │  │  • ultima_actualizacion          │        │      │    │
│  │  │  └──────────────────────────────────┘        │      │    │
│  │  │                                               │      │    │
│  │  └──────────────────────────────────────────────┘      │    │
│  │                                                          │    │
│  │  Volumen persistente: mysql_data                        │    │
│  └────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘


                ┌─────────────────────────────────┐
                │  Red Docker: empower_network    │
                │  Driver: bridge                 │
                └─────────────────────────────────┘
```

---

## 🔄 Flujo de Datos

### 1. Flujo de Registro de Usuario

```
Usuario (Browser)
    │
    │ 1. Completa formulario
    │    (nombre, apellidos, escuela, correo, contraseña)
    ▼
Flutter Web (registro_page.dart)
    │
    │ 2. Valida campos:
    │    • Correo: @gmail.com o @queretaro.tecnm.mx
    │    • Contraseña: 6-10 caracteres, mayúscula, minúscula, número
    │
    │ 3. POST /empower/register.php
    │    Content-Type: application/json
    │    Body: {nombre, apellidos, escuela, correo, contrasena}
    ▼
Backend PHP (register.php)
    │
    │ 4. Recibe JSON
    │ 5. Valida datos
    │ 6. Verifica que el correo no exista
    │ 7. Encripta contraseña con password_hash()
    │
    │ 8. INSERT INTO usuarios (...)
    │ 9. INSERT INTO puntos (usuario_id, 0, 0, 0, 0)
    ▼
MySQL Database
    │
    │ 10. Almacena usuario
    │ 11. Almacena registro de puntos inicial
    │
    │ 12. Retorna usuario_id
    ▼
Backend PHP
    │
    │ 13. Response JSON:
    │     {"status": "success", "message": "...", "usuario_id": X}
    ▼
Flutter Web
    │
    │ 14. Muestra mensaje de éxito
    │ 15. Navega a LoginPage
    ▼
Usuario puede iniciar sesión
```

### 2. Flujo de Inicio de Sesión

```
Usuario (Browser)
    │
    │ 1. Ingresa correo y contraseña
    ▼
Flutter Web (login_page.dart)
    │
    │ 2. Valida formato de correo
    │ 3. Valida longitud de contraseña (min 4)
    │
    │ 4. POST /empower/login.php
    │    Body: {correo, contrasena}
    ▼
Backend PHP (login.php)
    │
    │ 5. SELECT * FROM usuarios WHERE correo = ?
    ▼
MySQL Database
    │
    │ 6. Busca usuario
    │ 7. Retorna datos del usuario
    ▼
Backend PHP
    │
    │ 8. Verifica contraseña con password_verify()
    │ 9. Si es correcta:
    │    Response: {"status": "success", "usuario": {...}}
    │    Si es incorrecta:
    │    Response: {"status": "error", "message": "..."}
    ▼
Flutter Web
    │
    │ 10. Si success: Navigator.push(InicioPage)
    │     Si error: Muestra SnackBar con error
    ▼
Dashboard (inicio_page.dart)
```

### 3. Flujo de Consulta de Puntos

```
Usuario autenticado en InicioPage
    │
    │ 1. initState() llama obtenerPuntos()
    ▼
Flutter Web (inicio_page.dart)
    │
    │ 2. POST /empower/get_puntos.php
    │    Body: {correo: "usuario@ejemplo.com"}
    ▼
Backend PHP (get_puntos.php)
    │
    │ 3. SELECT u.*, p.*
    │    FROM usuarios u
    │    LEFT JOIN puntos p ON u.id = p.usuario_id
    │    WHERE u.correo = ?
    ▼
MySQL Database
    │
    │ 4. Retorna puntos del usuario
    ▼
Backend PHP
    │
    │ 5. Response JSON:
    │    {
    │      "status": "success",
    │      "plastico": 300,
    │      "carton": 400,
    │      "aluminio": 200,
    │      "total": 900
    │    }
    ▼
Flutter Web
    │
    │ 6. setState() actualiza variables
    │ 7. Renderiza widgets con puntos
    ▼
Usuario ve sus puntos en pantalla
```

---

## 🔒 Seguridad

### Medidas Implementadas:

1. **Contraseñas encriptadas:**
   - Uso de `password_hash()` con `PASSWORD_DEFAULT` (bcrypt)
   - Verificación con `password_verify()`

2. **Validación en Frontend:**
   - Formato de correo válido
   - Requisitos de contraseña fuerte
   - Solo dominios permitidos

3. **Validación en Backend:**
   - Sanitización de entradas
   - Prepared statements (previene SQL injection)
   - Validación de tipos de datos

4. **CORS configurado:**
   - Headers configurados en PHP y Nginx
   - Permite comunicación entre frontend y backend

### Medidas Recomendadas para Producción:

- [ ] Implementar JWT o sesiones
- [ ] Rate limiting en API
- [ ] HTTPS con certificado SSL
- [ ] Validación adicional de inputs
- [ ] Logs de auditoría
- [ ] Backup automático de BD

---

## 📊 Puertos y Servicios

| Servicio | Contenedor | Puerto Host | Puerto Interno | Protocolo |
|----------|------------|-------------|----------------|-----------|
| Frontend Web | empower_frontend | 80 | 80 | HTTP |
| Backend API | empower_backend | 8080 | 80 | HTTP |
| Base de Datos | empower_mysql | 3306 | 3306 | MySQL |

---

## 🌐 Red Docker

**Nombre:** `empower_network`
**Driver:** `bridge`
**Propósito:** Permite comunicación entre contenedores

Los contenedores se comunican usando sus nombres:
- Frontend → Backend: `http://backend/empower/`
- Backend → Database: `mysql://database:3306`

---

## 💾 Volúmenes Docker

| Volumen | Propósito | Persistencia |
|---------|-----------|--------------|
| `mysql_data` | Datos de MySQL | ✅ Persistente |
| `./backend` | Código PHP (montado) | 🔄 Sincronizado |
| `build/web` | Build de Flutter | ⚡ Generado |

---

## 🔄 Ciclo de Vida de la Aplicación

```
1. docker-compose up --build
   │
   ├─→ Construye imagen de backend (PHP + Apache)
   │   └─→ Instala extensiones mysqli, pdo, pdo_mysql
   │
   ├─→ Construye imagen de frontend (Flutter Web)
   │   ├─→ Clona Flutter SDK
   │   ├─→ flutter pub get
   │   ├─→ flutter build web --release
   │   └─→ Copia a Nginx
   │
   └─→ Inicia contenedor de MySQL
       └─→ Ejecuta init.sql (crea tablas y datos)

2. Contenedores corriendo
   │
   ├─→ frontend: Nginx sirve archivos estáticos
   ├─→ backend: Apache procesa peticiones PHP
   └─→ database: MySQL almacena datos

3. docker-compose down
   └─→ Detiene contenedores (datos persisten en mysql_data)
```

---

## 🚀 Escalabilidad Futura

### Posibles Mejoras:

1. **Cache Layer:**
   ```
   Frontend → Redis → Backend → Database
   ```

2. **Load Balancer:**
   ```
   Nginx LB → [Backend 1, Backend 2, Backend N]
   ```

3. **Microservicios:**
   ```
   Auth Service | Points Service | User Service
   ```

4. **API Gateway:**
   ```
   Frontend → Kong/Traefik → Microservicios
   ```

---

**Arquitectura actual:** Monolito de 3 capas (Frontend, Backend, Database)
**Patrón:** MVC (Model-View-Controller) con API REST
**Despliegue:** Docker Compose (desarrollo/staging)
**Escalabilidad:** Lista para migrar a Kubernetes
