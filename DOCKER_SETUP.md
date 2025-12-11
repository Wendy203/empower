# 🐳 Guía de Instalación con Docker - Empower App

Esta guía te ayudará a ejecutar el proyecto Empower completo usando Docker.

## 📋 Prerequisitos

Asegúrate de tener instalado en tu sistema:

- **Docker Desktop** (Windows/Mac) o **Docker Engine** (Linux)
  - Descarga: https://www.docker.com/products/docker-desktop
- **Docker Compose** (generalmente viene incluido con Docker Desktop)

Para verificar la instalación:
```bash
docker --version
docker-compose --version
```

---

## 🏗️ Arquitectura del Proyecto

El proyecto se compone de 3 contenedores Docker:

1. **Frontend (Flutter Web)** - Puerto 80
   - Aplicación web Flutter servida con Nginx
   - Interfaz de usuario para login, registro y dashboard

2. **Backend (PHP)** - Puerto 8080
   - API REST con endpoints: login, register, get_puntos
   - Servidor Apache con PHP 8.2

3. **Database (MySQL)** - Puerto 3306
   - Base de datos MySQL 8.0
   - Almacena usuarios y puntos de reciclaje

---

## 🚀 Instalación y Ejecución

### Paso 1: Clonar o descargar el proyecto

Si ya tienes el proyecto descargado, navega al directorio:
```bash
cd c:\Users\josem\Downloads\empower
```

### Paso 2: Construir y levantar los contenedores

Ejecuta el siguiente comando para construir todas las imágenes y levantar los servicios:

```bash
docker-compose up --build
```

**Nota:** La primera vez puede tardar varios minutos (5-15 min) porque descarga Flutter y todas las dependencias.

Para ejecutar en segundo plano (modo detached):
```bash
docker-compose up -d --build
```

### Paso 3: Verificar que los servicios estén corriendo

```bash
docker-compose ps
```

Deberías ver algo como:
```
NAME                  STATUS    PORTS
empower_frontend      Up        0.0.0.0:80->80/tcp
empower_backend       Up        0.0.0.0:8080->80/tcp
empower_mysql         Up        0.0.0.0:3306->3306/tcp
```

### Paso 4: Acceder a la aplicación

- **Frontend (Aplicación Web):** http://localhost
- **Backend API:** http://localhost:8080
- **Base de datos:** localhost:3306

---

## 🧪 Probar la Aplicación

### Credenciales de prueba pre-creadas:

**Usuario 1:**
- Correo: `test@gmail.com`
- Contraseña: `test123`
- Puntos: 900 (300 plástico, 400 cartón, 200 aluminio)

**Usuario 2:**
- Correo: `juan.perez@queretaro.tecnm.mx`
- Contraseña: (sin contraseña de prueba, registra uno nuevo)

### Registrar un nuevo usuario:

1. Abre http://localhost
2. Haz clic en "Registrarse"
3. Completa el formulario:
   - Nombre y apellidos
   - Escuela
   - Correo (debe ser @gmail.com o @queretaro.tecnm.mx)
   - Contraseña (6-10 caracteres, con mayúscula, minúscula y número)
4. Haz clic en "Registrarse"
5. Inicia sesión con tus credenciales

---

## 🛠️ Comandos Útiles

### Ver logs de todos los servicios:
```bash
docker-compose logs -f
```

### Ver logs de un servicio específico:
```bash
docker-compose logs -f frontend
docker-compose logs -f backend
docker-compose logs -f database
```

### Detener los contenedores:
```bash
docker-compose down
```

### Detener y eliminar volúmenes (BORRA LA BASE DE DATOS):
```bash
docker-compose down -v
```

### Reconstruir un servicio específico:
```bash
docker-compose up -d --build frontend
```

### Acceder a la consola de un contenedor:
```bash
# Backend PHP
docker exec -it empower_backend bash

# Base de datos MySQL
docker exec -it empower_mysql mysql -u empower_user -p
# Contraseña: empower_pass_123
```

### Ver la base de datos:
```bash
docker exec -it empower_mysql mysql -u empower_user -pempower_pass_123 empower_db
```

Dentro de MySQL:
```sql
SHOW TABLES;
SELECT * FROM usuarios;
SELECT * FROM puntos;
```

---

## 🔧 Configuración Avanzada

### Cambiar puertos

Edita el archivo `docker-compose.yml` y modifica la sección `ports`:

```yaml
services:
  frontend:
    ports:
      - "3000:80"  # Cambia el puerto 80 a 3000
```

### Variables de entorno

Copia el archivo `.env.example` a `.env` y modifica las credenciales:

```bash
cp .env.example .env
```

Luego edita `.env` con tus valores personalizados.

### Modificar el código PHP

Los archivos del backend están en `backend/empower/`. Cualquier cambio se refleja inmediatamente (sin necesidad de reconstruir):

- `backend/empower/login.php`
- `backend/empower/register.php`
- `backend/empower/get_puntos.php`

### Modificar el código Flutter

Si modificas archivos en `lib/`, necesitas reconstruir el frontend:

```bash
docker-compose up -d --build frontend
```

---

## 📊 Estructura de la Base de Datos

### Tabla: `usuarios`
| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | INT | ID único del usuario |
| nombre | VARCHAR(100) | Nombre del usuario |
| apellidos | VARCHAR(100) | Apellidos |
| escuela | VARCHAR(200) | Institución educativa |
| correo | VARCHAR(150) | Email (único) |
| contrasena | VARCHAR(255) | Contraseña encriptada |
| fecha_registro | TIMESTAMP | Fecha de registro |

### Tabla: `puntos`
| Campo | Tipo | Descripción |
|-------|------|-------------|
| id | INT | ID único |
| usuario_id | INT | Referencia al usuario |
| plastico | INT | Puntos por plástico |
| carton | INT | Puntos por cartón |
| aluminio | INT | Puntos por aluminio |
| total | INT | Total de puntos |
| ultima_actualizacion | TIMESTAMP | Última actualización |

---

## 🐛 Troubleshooting (Solución de Problemas)

### Error: "Port 80 is already in use"
Otro servicio está usando el puerto 80. Opciones:
1. Detén el otro servicio (Apache, IIS, etc.)
2. Cambia el puerto en `docker-compose.yml`:
   ```yaml
   frontend:
     ports:
       - "8000:80"  # Ahora accede en http://localhost:8000
   ```

### Error: "Cannot connect to the Docker daemon"
Docker Desktop no está corriendo. Inicia Docker Desktop.

### Error: "No se pudo conectar con el servidor" en la app
1. Verifica que el backend esté corriendo:
   ```bash
   curl http://localhost:8080/empower/login.php
   ```
2. Revisa los logs del backend:
   ```bash
   docker-compose logs backend
   ```

### La aplicación web no carga
1. Verifica que el contenedor esté corriendo:
   ```bash
   docker-compose ps
   ```
2. Revisa los logs del frontend:
   ```bash
   docker-compose logs frontend
   ```
3. Intenta reconstruir:
   ```bash
   docker-compose down
   docker-compose up --build
   ```

### Error al construir el frontend (Flutter)
Si la construcción de Flutter falla:
1. Asegúrate de tener suficiente espacio en disco (mínimo 5GB libres)
2. Aumenta la memoria asignada a Docker:
   - Docker Desktop → Settings → Resources → Memory: 4GB mínimo

### La base de datos no tiene datos
Reinicia los contenedores para ejecutar el script de inicialización:
```bash
docker-compose down -v
docker-compose up --build
```

---

## 📦 Despliegue en Producción

### Consideraciones de seguridad:

1. **Cambia las contraseñas** en `.env`:
   - MYSQL_ROOT_PASSWORD
   - DB_PASSWORD

2. **Deshabilita CORS abierto** en `backend/config.php`:
   ```php
   header('Access-Control-Allow-Origin: https://tu-dominio.com');
   ```

3. **Configura HTTPS** usando un reverse proxy (Nginx/Traefik) con Let's Encrypt

4. **Usa volúmenes persistentes** para la base de datos (ya configurado en docker-compose.yml)

---

## 📞 Soporte

Si encuentras problemas:
1. Revisa los logs: `docker-compose logs -f`
2. Verifica que los 3 contenedores estén corriendo: `docker-compose ps`
3. Asegúrate de que los puertos no estén en uso
4. Intenta reconstruir desde cero: `docker-compose down -v && docker-compose up --build`

---

## 🎉 ¡Listo!

Ahora puedes desarrollar y probar la aplicación Empower completamente con Docker.

**URLs importantes:**
- Frontend: http://localhost
- Backend API: http://localhost:8080
- MySQL: localhost:3306

**Credenciales de prueba:**
- Correo: `test@gmail.com`
- Contraseña: `test123`
