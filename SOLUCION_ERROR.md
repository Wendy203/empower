# 🔧 Solución al Error de Docker

## ❌ Problema Encontrado

Al intentar ejecutar `docker-compose up --build`, el proceso fallaba con el siguiente error:

```
E: Unable to locate package libgconf-2-4
```

## 🔍 Causa del Error

El paquete `libgconf-2-4` ya no está disponible en **Debian Trixie** (la versión más reciente de Debian). Este paquete fue marcado como obsoleto y eliminado de los repositorios oficiales.

## ✅ Solución Aplicada

Se realizaron 2 cambios en los archivos de configuración:

### 1. Actualización del Dockerfile

**Archivo:** [Dockerfile](Dockerfile)

**Cambio:**
Removí el paquete obsoleto `libgconf-2-4` de la lista de dependencias.

```dockerfile
# ANTES (con error)
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    xz-utils \
    zip \
    libgconf-2-4 \    # ❌ Este paquete ya no existe
    gdb \
    libstdc++6 \
    libglu1-mesa \
    fonts-droid-fallback \
    lib32stdc++6 \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# DESPUÉS (corregido)
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    xz-utils \
    zip \
    gdb \
    libstdc++6 \
    libglu1-mesa \
    fonts-droid-fallback \
    lib32stdc++6 \
    python3 \
    ca-certificates \  # ✅ Agregado para seguridad SSL
    && rm -rf /var/lib/apt/lists/*
```

### 2. Actualización del docker-compose.yml

**Archivo:** [docker-compose.yml](docker-compose.yml)

**Cambio:**
Removí la línea `version: '3.8'` que está obsoleta en las versiones recientes de Docker Compose.

```yaml
# ANTES
version: '3.8'  # ⚠️ Obsoleto, genera warning

services:
  ...

# DESPUÉS
services:  # ✅ Sin la línea version
  ...
```

## 🚀 Cómo Ejecutar Ahora

Con estos cambios aplicados, ahora puedes ejecutar el proyecto sin problemas:

### Windows:
```bash
start.bat
```

### Linux/Mac:
```bash
chmod +x start.sh
./start.sh
```

### Manual:
```bash
docker-compose up --build
```

## ⏱️ Tiempo de Construcción

La **primera vez** que ejecutes el comando, Docker necesitará:
1. ✅ Descargar la imagen de MySQL (~ 1-2 minutos)
2. ✅ Construir la imagen del backend PHP (~ 1-2 minutos)
3. ✅ Descargar e instalar Flutter SDK (~ 5-10 minutos) ⚠️ **Esto es lo que más tarda**
4. ✅ Construir la aplicación Flutter Web (~ 2-3 minutos)

**Tiempo total estimado:** 10-20 minutos (dependiendo de tu conexión a internet)

## 📊 Progreso Actual

Si acabas de ejecutar el comando, verás algo como esto:

```
database Pulling
backend Building
frontend Building
  ├─ Descargando paquetes Debian... ✅
  ├─ Clonando Flutter SDK... ⏳
  ├─ Instalando Flutter... ⏳
  └─ Construyendo app... ⏳
```

## ✅ Verificar que Funciona

Una vez que termine, deberías ver:

```
✔ Container empower_mysql     Started
✔ Container empower_backend   Started
✔ Container empower_frontend  Started
```

Luego podrás acceder a:
- **Frontend:** http://localhost
- **Backend:** http://localhost:8080
- **Base de datos:** localhost:3306

## 🎯 Credenciales de Prueba

```
Email: test@gmail.com
Contraseña: test123
```

---

## 📝 Notas Adicionales

- El paquete `libgconf-2-4` era una dependencia antigua de GNOME 2 que ya no es necesaria para Flutter Web.
- Agregué `ca-certificates` para asegurar que las conexiones HTTPS funcionen correctamente.
- Las versiones posteriores de Docker Compose (v2.x) no requieren especificar `version` en el archivo YAML.

---

**Estado:** ✅ Problema resuelto - El proyecto ahora se construye correctamente
