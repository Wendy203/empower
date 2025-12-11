# 📱 Proyecto Empower - Análisis Completo

## 🎯 Descripción General

**Empower** es una aplicación móvil/web desarrollada en Flutter que permite a usuarios de instituciones educativas:
- ✅ Registrarse e iniciar sesión
- ♻️ Rastrear puntos de reciclaje (plástico, cartón, aluminio)
- 👤 Gestionar su perfil de usuario
- 📊 Ver estadísticas de sus contribuciones al reciclaje

---

## 🏗️ Arquitectura del Proyecto

### **Frontend** (Flutter/Dart)
- **Framework:** Flutter 3.35.4
- **Lenguaje:** Dart 3.9.2
- **Plataformas:** iOS, Android, Web, Windows, Linux, macOS
- **Páginas principales:**
  - [main.dart](lib/main.dart) - Punto de entrada
  - [login_page.dart](lib/login_page.dart) - Autenticación
  - [registro_page.dart](lib/registro_page.dart) - Registro de usuarios
  - [inicio_page.dart](lib/inicio_page.dart) - Dashboard con puntos
  - [perfil_page.dart](lib/perfil_page.dart) - Perfil de usuario

### **Backend** (PHP + MySQL)
- **Lenguaje:** PHP 8.2
- **Base de datos:** MySQL 8.0
- **Endpoints API:**
  - `POST /empower/login.php` - Inicio de sesión
  - `POST /empower/register.php` - Registro de usuarios
  - `POST /empower/get_puntos.php` - Obtener puntos de reciclaje

### **Base de Datos** (MySQL)
**Tablas:**
1. `usuarios` - Información de usuarios registrados
2. `puntos` - Puntos de reciclaje por usuario y material

---

## 📦 Dependencias del Proyecto

```yaml
dependencies:
  flutter: sdk
  cupertino_icons: ^1.0.8  # Iconos iOS
  http: ^1.1.0             # Peticiones HTTP al backend
```

---

## 🐳 Instalación con Docker (RECOMENDADO)

### ⚡ Inicio Rápido

#### Windows:
```bash
start.bat
```

#### Linux/Mac:
```bash
chmod +x start.sh
./start.sh
```

### 📝 Instalación Manual

1. **Asegúrate de tener Docker instalado:**
   ```bash
   docker --version
   docker-compose --version
   ```

2. **Navega al directorio del proyecto:**
   ```bash
   cd c:\Users\josem\Downloads\empower
   ```

3. **Inicia los contenedores:**
   ```bash
   docker-compose up --build
   ```

4. **Espera a que se completen las construcciones** (5-15 minutos la primera vez)

5. **Accede a la aplicación:**
   - Frontend: http://localhost
   - Backend: http://localhost:8080
   - Base de datos: localhost:3306

---

## 🔐 Credenciales de Prueba

**Usuario de demostración:**
```
Email: test@gmail.com
Contraseña: test123
Puntos: 900 (300 plástico, 400 cartón, 200 aluminio)
```

**O registra un nuevo usuario:**
- Dominios permitidos: `@gmail.com` o `@queretaro.tecnm.mx`
- Contraseña: 6-10 caracteres, debe incluir mayúscula, minúscula y número

---

## 📂 Estructura del Proyecto

```
empower/
├── 📱 lib/                          # Código fuente Flutter
│   ├── main.dart                   # Punto de entrada
│   ├── login_page.dart             # Pantalla de login
│   ├── registro_page.dart          # Pantalla de registro
│   ├── inicio_page.dart            # Dashboard de puntos
│   └── perfil_page.dart            # Perfil de usuario
│
├── 🖼️ assets/                       # Recursos (imágenes)
│   └── imagenes/
│       ├── logo.png
│       └── perfil.png
│
├── 🐘 backend/                      # Backend PHP (CREADO)
│   ├── Dockerfile                  # Imagen Docker del backend
│   ├── config.php                  # Configuración de BD
│   ├── init.sql                    # Script de inicialización DB
│   ├── index.php                   # Página de inicio API
│   └── empower/
│       ├── login.php               # Endpoint de login
│       ├── register.php            # Endpoint de registro
│       └── get_puntos.php          # Endpoint de puntos
│
├── 🐳 Docker/                       # Configuración Docker
│   ├── Dockerfile                  # Imagen Flutter Web
│   ├── docker-compose.yml          # Orquestación de servicios
│   ├── nginx.conf                  # Configuración Nginx
│   └── .dockerignore              # Archivos ignorados
│
├── 📄 Documentación/
│   ├── README_DOCKER.md            # Guía rápida Docker
│   ├── DOCKER_SETUP.md             # Guía completa Docker
│   ├── RESUMEN_PROYECTO.md         # Este archivo
│   └── .env.example                # Variables de entorno ejemplo
│
├── 🚀 Scripts de inicio/
│   ├── start.bat                   # Iniciar (Windows)
│   ├── start.sh                    # Iniciar (Linux/Mac)
│   ├── stop.bat                    # Detener (Windows)
│   └── stop.sh                     # Detener (Linux/Mac)
│
└── 📝 Configuración/
    ├── pubspec.yaml                # Dependencias Flutter
    ├── analysis_options.yaml       # Reglas de análisis
    └── .metadata                   # Metadata de Flutter
```

---

## 🛠️ Comandos Útiles

### Docker

```bash
# Ver contenedores corriendo
docker-compose ps

# Ver logs en tiempo real
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f frontend
docker-compose logs -f backend
docker-compose logs -f database

# Detener contenedores
docker-compose down

# Detener y eliminar volúmenes (BORRA LA BD)
docker-compose down -v

# Reconstruir un servicio
docker-compose up -d --build frontend

# Acceder al contenedor del backend
docker exec -it empower_backend bash

# Acceder a MySQL
docker exec -it empower_mysql mysql -u empower_user -pempower_pass_123 empower_db
```

### Flutter (desarrollo local sin Docker)

```bash
# Instalar dependencias
flutter pub get

# Ejecutar en web
flutter run -d chrome

# Ejecutar en Windows
flutter run -d windows

# Ejecutar tests
flutter test

# Construir para producción
flutter build web
flutter build apk
flutter build windows
```

---

## 🌐 URLs y Puertos

| Servicio | URL | Puerto |
|----------|-----|--------|
| **Frontend (Flutter Web)** | http://localhost | 80 |
| **Backend (PHP API)** | http://localhost:8080 | 8080 |
| **Base de Datos (MySQL)** | localhost:3306 | 3306 |

---

## 🗄️ Base de Datos

### Configuración

```
Host: database (dentro de Docker) / localhost (desde tu PC)
Puerto: 3306
Base de datos: empower_db
Usuario: empower_user
Contraseña: empower_pass_123
Root password: root_password_123
```

### Esquema de Tablas

#### Tabla: `usuarios`
```sql
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    escuela VARCHAR(200) NOT NULL,
    correo VARCHAR(150) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Tabla: `puntos`
```sql
CREATE TABLE puntos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    plastico INT DEFAULT 0,
    carton INT DEFAULT 0,
    aluminio INT DEFAULT 0,
    total INT DEFAULT 0,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);
```

---

## 🔌 API Endpoints

### 1. Login
**Endpoint:** `POST /empower/login.php`

**Request:**
```json
{
  "correo": "test@gmail.com",
  "contrasena": "test123"
}
```

**Response (éxito):**
```json
{
  "status": "success",
  "message": "Inicio de sesión exitoso.",
  "usuario": {
    "id": 1,
    "nombre": "Usuario",
    "apellidos": "De Prueba",
    "correo": "test@gmail.com"
  }
}
```

### 2. Registro
**Endpoint:** `POST /empower/register.php`

**Request:**
```json
{
  "nombre": "Juan",
  "apellidos": "Pérez García",
  "escuela": "Instituto Tecnológico de Querétaro",
  "correo": "juan@gmail.com",
  "contrasena": "Pass123"
}
```

**Response (éxito):**
```json
{
  "status": "success",
  "message": "Usuario registrado exitosamente.",
  "usuario_id": 4
}
```

### 3. Obtener Puntos
**Endpoint:** `POST /empower/get_puntos.php`

**Request:**
```json
{
  "correo": "test@gmail.com"
}
```

**Response (éxito):**
```json
{
  "status": "success",
  "plastico": 300,
  "carton": 400,
  "aluminio": 200,
  "total": 900
}
```

---

## 🐛 Troubleshooting

### Error: "Puerto 80 ya está en uso"
**Solución:** Edita [docker-compose.yml](docker-compose.yml) línea 54:
```yaml
ports:
  - "8000:80"  # Cambia 80 a 8000
```
Luego accede en: http://localhost:8000

### Error: "No se pudo conectar con el servidor"
**Verificaciones:**
1. Verifica que los contenedores estén corriendo:
   ```bash
   docker-compose ps
   ```
2. Revisa los logs del backend:
   ```bash
   docker-compose logs backend
   ```
3. Prueba el backend directamente:
   ```bash
   curl http://localhost:8080
   ```

### Error: La aplicación web no carga
**Solución:**
```bash
# Detener todo
docker-compose down -v

# Reconstruir desde cero
docker-compose up --build
```

### Error: Flutter build falla
**Requisitos:**
- Al menos 5GB de espacio libre
- Docker Desktop con mínimo 4GB de RAM asignado
- Conexión a internet estable para descargar Flutter SDK

---

## 📋 Checklist de Verificación

Antes de reportar un problema, verifica:

- [ ] Docker Desktop está instalado y corriendo
- [ ] Los puertos 80, 8080 y 3306 están disponibles
- [ ] Tienes al menos 5GB de espacio libre
- [ ] Los 3 contenedores están corriendo (`docker-compose ps`)
- [ ] Puedes acceder a http://localhost
- [ ] El backend responde en http://localhost:8080

---

## 📖 Documentación Adicional

- **Guía Rápida:** [README_DOCKER.md](README_DOCKER.md)
- **Guía Detallada:** [DOCKER_SETUP.md](DOCKER_SETUP.md)
- **Configuración:** [.env.example](.env.example)

---

## 🚀 Despliegue en Producción

### Seguridad:
1. ✅ Cambia las contraseñas en `.env`
2. ✅ Configura CORS específico en `backend/config.php`
3. ✅ Usa HTTPS con certificado SSL
4. ✅ Configura backup automático de la base de datos
5. ✅ Implementa autenticación JWT o sessions

### Recomendaciones:
- Usa un servidor con al menos 2GB RAM
- Configura un reverse proxy (Nginx/Traefik)
- Implementa rate limiting en el backend
- Habilita logs persistentes
- Configura monitoreo con Prometheus/Grafana

---

## 📞 Soporte

**Archivos importantes creados para este proyecto:**

1. **Docker:**
   - [Dockerfile](Dockerfile) - Imagen Flutter Web
   - [docker-compose.yml](docker-compose.yml) - Orquestación
   - [nginx.conf](nginx.conf) - Configuración Nginx
   - [backend/Dockerfile](backend/Dockerfile) - Imagen PHP

2. **Backend:**
   - [backend/init.sql](backend/init.sql) - Script de BD
   - [backend/config.php](backend/config.php) - Configuración
   - [backend/empower/*.php](backend/empower/) - Endpoints API

3. **Scripts:**
   - [start.bat](start.bat) / [start.sh](start.sh) - Iniciar
   - [stop.bat](stop.bat) / [stop.sh](stop.sh) - Detener

4. **Documentación:**
   - Este archivo
   - [DOCKER_SETUP.md](DOCKER_SETUP.md)
   - [README_DOCKER.md](README_DOCKER.md)

---

## ✅ Estado del Proyecto

| Componente | Estado | Notas |
|------------|--------|-------|
| Frontend Flutter | ✅ Completo | 5 páginas funcionales |
| Backend PHP | ✅ Completo | 3 endpoints creados |
| Base de Datos | ✅ Completo | Esquema y datos de prueba |
| Docker Setup | ✅ Completo | 3 contenedores configurados |
| Documentación | ✅ Completo | Guías detalladas |
| Scripts de inicio | ✅ Completo | Windows y Linux/Mac |

---

**🎉 ¡El proyecto está completamente listo para ejecutarse con Docker!**

Para iniciar, simplemente ejecuta:
- **Windows:** `start.bat`
- **Linux/Mac:** `./start.sh`

O manualmente:
```bash
docker-compose up --build
```

Luego accede a http://localhost y usa las credenciales de prueba.
