# ♻️ Empower - Aplicación de Reciclaje

**Empower** es una aplicación multiplataforma (Web, iOS, Android) desarrollada en Flutter que permite a estudiantes rastrear y gestionar sus puntos de reciclaje de materiales como plástico, cartón y aluminio.

---

## 🚀 Inicio Rápido con Docker (Recomendado)

### Prerrequisitos
- [Docker Desktop](https://www.docker.com/products/docker-desktop) instalado y corriendo

### Instalación en 3 pasos:

#### Windows:
```bash
start.bat
```

#### Linux/Mac:
```bash
chmod +x start.sh
./start.sh
```

#### Manual:
```bash
docker-compose up --build
```

**Accede a la aplicación en:** http://localhost

**Credenciales de prueba:**
- Email: `test@gmail.com`
- Contraseña: `test123`

---

## 📚 Documentación

- **[Guía Rápida de Docker](README_DOCKER.md)** - Inicio rápido y comandos básicos
- **[Guía Completa de Docker](DOCKER_SETUP.md)** - Instalación detallada y troubleshooting
- **[Resumen del Proyecto](RESUMEN_PROYECTO.md)** - Arquitectura, API, base de datos

---

## 🏗️ Arquitectura

**Frontend:** Flutter Web (Nginx)
- Puerto: 80
- URL: http://localhost

**Backend:** PHP 8.2 (Apache)
- Puerto: 8080
- URL: http://localhost:8080

**Base de Datos:** MySQL 8.0
- Puerto: 3306
- Host: localhost

---

## 🛠️ Desarrollo Local (sin Docker)

### Prerrequisitos
- Flutter SDK 3.35.4+
- Dart SDK 3.9.2+
- PHP 8.2+
- MySQL 8.0+

### Instalación

```bash
# Instalar dependencias
flutter pub get

# Ejecutar en web
flutter run -d chrome

# Ejecutar en Windows
flutter run -d windows

# Construir para producción
flutter build web
```

---

## 📂 Estructura del Proyecto

```
empower/
├── lib/                    # Código fuente Flutter
│   ├── main.dart          # Punto de entrada
│   ├── login_page.dart    # Pantalla de login
│   ├── registro_page.dart # Registro de usuarios
│   ├── inicio_page.dart   # Dashboard
│   └── perfil_page.dart   # Perfil
├── backend/               # Backend PHP (API REST)
│   ├── empower/          # Endpoints
│   ├── init.sql          # Script de BD
│   └── config.php        # Configuración
├── assets/               # Recursos (imágenes)
├── Dockerfile           # Imagen Docker frontend
├── docker-compose.yml   # Orquestación
└── README.md           # Este archivo
```

---

## 🔌 API Endpoints

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| POST | `/empower/login.php` | Inicio de sesión |
| POST | `/empower/register.php` | Registro de usuarios |
| POST | `/empower/get_puntos.php` | Obtener puntos |

Ver documentación completa en [RESUMEN_PROYECTO.md](RESUMEN_PROYECTO.md#-api-endpoints)

---

## 🧪 Probar la API

### Windows:
```bash
test-api.bat
```

### Linux/Mac:
```bash
./test-api.sh
```

---

## 🛑 Detener la Aplicación

### Windows:
```bash
stop.bat
```

### Linux/Mac:
```bash
./stop.sh
```

---

## 📊 Base de Datos

**Credenciales:**
```
Host: localhost
Puerto: 3306
Base de datos: empower_db
Usuario: empower_user
Contraseña: empower_pass_123
```

**Tablas:**
- `usuarios` - Información de usuarios
- `puntos` - Puntos de reciclaje por material

---

## 🐛 Troubleshooting

**Puerto 80 ocupado:**
Edita `docker-compose.yml` y cambia el puerto:
```yaml
frontend:
  ports:
    - "8000:80"
```

**Ver logs:**
```bash
docker-compose logs -f
```

**Reconstruir desde cero:**
```bash
docker-compose down -v
docker-compose up --build
```

Ver más soluciones en [DOCKER_SETUP.md](DOCKER_SETUP.md#-troubleshooting-soluci%C3%B3n-de-problemas)

---

## 📞 Soporte

- **Documentación completa:** [DOCKER_SETUP.md](DOCKER_SETUP.md)
- **Análisis del proyecto:** [RESUMEN_PROYECTO.md](RESUMEN_PROYECTO.md)
- **Configuración:** [.env.example](.env.example)

---

## 🎯 Tecnologías

- **Frontend:** Flutter 3.35.4, Dart 3.9.2
- **Backend:** PHP 8.2, Apache
- **Base de Datos:** MySQL 8.0
- **Contenedores:** Docker, Docker Compose
- **Web Server:** Nginx

---

## ✅ Estado

- ✅ Frontend Flutter completamente funcional
- ✅ Backend PHP con 3 endpoints
- ✅ Base de datos MySQL configurada
- ✅ Docker Compose listo para usar
- ✅ Documentación completa

---

**Desarrollado con Flutter - Listo para ejecutar con Docker**
