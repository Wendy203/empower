# 📘 Manual Técnico - Empower: Aplicación de Reciclaje

**Fecha de Generación:** 11 de Diciembre, 2025
**Versión del Documento:** 1.0

---

## 📋 1. Introducción

### 1.1 Objetivo del Documento
El presente Manual Técnico tiene como objetivo detallar la arquitectura, diseño, implementación y despliegue del sistema **Empower**. Este documento está dirigido a desarrolladores, administradores de sistemas y personal técnico encargado del mantenimiento y evolución de la aplicación.

### 1.2 Descripción del Sistema
Empower es una solución multiplataforma desarrollada en **Flutter** (Frontend) y **PHP** (Backend) diseñada para incentivar y gestionar el reciclaje en entornos educativos. Permite a los estudiantes registrar materiales reciclables (plástico, cartón, aluminio) y acumular puntos que pueden visualizar en un dashboard interactivo.

### 1.3 Alcance
El sistema abarca:
- Aplicación web responsiva (y móvil mediante compilación nativa).
- Backend API RESTful.
- Base de datos relacional para persistencia.
- Entorno de contenerización para despliegue consistente.

---

## 🛠️ 2. Stack Tecnológico

La aplicación utiliza una arquitectura moderna basada en contenedores. A continuación se detallan las tecnologías y versiones empleadas:

| Capa | Tecnología | Versión | Descripción |
|------|------------|---------|-------------|
| **Frontend** | Flutter | 3.35.4 | Framework UI multiplataforma. |
| | Dart | 3.9.2 | Lenguaje de programación para el frontend. |
| **Backend** | PHP | 8.2 | Lenguaje de scripting del lado del servidor. |
| | Apache | 2.4.x | Servidor web para el backend. |
| **Base de Datos** | MySQL | 8.0 | Sistema de gestión de base de datos relacional. |
| **Servidor Web** | Nginx | Latest | Servidor web y proxy reverso para el frontend. |
| **Infraestructura** | Docker | Latest | Plataforma de contenerización. |
| | Docker Compose | Latest | Orquestación de contenedores. |

---

## 🏗️ 3. Arquitectura del Sistema

El sistema implementa una arquitectura de **3 capas** contenerizada dentro de una red Docker privada (`empower_network`), exponiendo solo los puertos necesarios.

### 3.1 Diagrama de Arquitectura

```mermaid
graph TD
    User[Usuario (Navegador)] -->|HTTP Port 80| Nginx[Nginx Web Server]
    subgraph "Contenedor Frontend"
        Nginx --> Flutter[Flutter Web App]
    end
    
    Nginx -->|Proxy /empower/| Apache[Apache Web Server]
    
    subgraph "Contenedor Backend"
        Apache --> PHP[PHP API]
    end
    
    PHP -->|MySQL Protocol Port 3306| DB[(MySQL Database)]
    
    subgraph "Contenedor Database"
        DB
    end
```

### 3.2 Comunicación entre Componentes
1.  **Frontend (Cliente)**: La aplicación Flutter realiza peticiones HTTP asíncronas a la API.
2.  **Proxy Reverso**: Nginx sirve la aplicación Flutter en la ruta raíz `/` y redirige las peticiones que comienzan con `/empower/` hacia el contenedor del backend.
3.  **Backend (Servidor)**: PHP procesa las peticiones, valida la lógica de negocio y se comunica con la base de datos.
4.  **Persistencia**: MySQL almacena la información de usuarios y puntos.

---

## 📂 4. Estructura del Proyecto

La organización del código fuente sigue las mejores prácticas para facilitar la escalabilidad y el mantenimiento.

### 4.1 Directorio Raíz (`empower/`)

| Archivo/Directorio | Descripción |
|--------------------|-------------|
| `lib/` | Código fuente de la aplicación Flutter. |
| `backend/` | Código fuente del API Backend. |
| `assets/` | Recursos estáticos (imágenes, fuentes). |
| `docker-compose.yml` | Declaración de servicios, redes y volúmenes. |
| `Dockerfile` | Definición de la imagen para el Frontend. |
| `init.sql` | Script de inicialización de la base de datos (dentro de backend or root). |

### 4.2 Estructura del Frontend (`lib/`)

```
lib/
├── main.dart             # Punto de entrada de la aplicación. Configura rutas y tema.
├── login_page.dart       # Pantalla de inicio de sesión. Maneja autenticación.
├── registro_page.dart    # Formulario de registro con validaciones complejas.
├── inicio_page.dart      # Dashboard principal. Muestra los puntos del usuario.
├── perfil_page.dart      # Pantalla de perfil de usuario.
└── configuracion_page.dart # Opciones de configuración de la app.
```

### 4.3 Estructura del Backend (`backend/`)

```
backend/
├── config.php            # Configuración de conexión a BD (host, user, pass).
└── empower/              # Endpoints públicos de la API.
    ├── login.php         # Endpoint para autenticación.
    ├── register.php      # Endpoint para creación de usuarios.
    └── get_puntos.php    # Endpoint para consulta de saldo de puntos.
```

---

## 💾 5. Base de Datos

El sistema utiliza **MySQL** con una base de datos llamada `empower_db`.

### 5.1 Esquema Relacional

#### Tabla `usuarios`
Almacena la información de identidad de los estudiantes.

| Columna | Tipo | Restricciones | Descripción |
|---------|------|---------------|-------------|
| `id` | INT | PK, AI | Identificador único. |
| `nombre` | VARCHAR(100) | NOT NULL | Nombre del estudiante. |
| `apellidos` | VARCHAR(100) | NOT NULL | Apellidos del estudiante. |
| `escuela` | VARCHAR(100) | | Institución educativa. |
| `correo` | VARCHAR(150) | UNIQUE | Email institucional o personal. |
| `contrasena` | VARCHAR(255) | NOT NULL | Hash de la contraseña (BCRYPT). |
| `fecha_registro` | DATETIME | DEFAULT NOW | Timestamp de creación. |

#### Tabla `puntos`
Almacena el saldo de reciclaje asociado a cada usuario.

| Columna | Tipo | Restricciones | Descripción |
|---------|------|---------------|-------------|
| `id` | INT | PK, AI | Identificador del registro. |
| `usuario_id` | INT | FK | Referencia a la tabla `usuarios`. |
| `plastico` | INT | DEFAULT 0 | Cantidad de puntos por plástico. |
| `carton` | INT | DEFAULT 0 | Cantidad de puntos por cartón. |
| `aluminio` | INT | DEFAULT 0 | Cantidad de puntos por aluminio. |
| `total` | INT | DEFAULT 0 | Sumatoria total de puntos. |
| `ultima_actualizacion` | TIMESTAMP | | Fecha de último movimiento. |

---

## 🔌 6. API REST

El backend expone una API RESTful consumida por el frontend mediante peticiones HTTP POST con cargas JSON.

### 6.1 Endpoints

#### `POST /empower/login.php`
*   **Descripción:** Autentica a un usuario en el sistema.
*   **Body:**
    ```json
    {
      "correo": "usuario@ejemplo.com",
      "contrasena": "Password123"
    }
    ```
*   **Respuesta Exitosa:**
    ```json
    {
      "status": "success",
      "message": "Login exitoso",
      "usuario": { "id": 1, "nombre": "Juan", ... }
    }
    ```

#### `POST /empower/register.php`
*   **Descripción:** Registra un nuevo usuario e inicializa su contador de puntos a 0.
*   **Body:**
    ```json
    {
      "nombre": "Juan",
      "apellidos": "Perez",
      "escuela": "TecNM",
      "correo": "juan@gmail.com",
      "contrasena": "Password123"
    }
    ```
*   **Lógica:** Verifica duplicidad de correo y realiza hashing de contraseña antes de guardar.

#### `POST /empower/get_puntos.php`
*   **Descripción:** Recupera el desglose de puntos de un usuario específico.
*   **Body:**
    ```json
    { "correo": "juan@gmail.com" }
    ```

---

## 🚀 7. Guía de Instalación y Despliegue

### 7.1 Prerrequisitos
*   **Docker Desktop** instalado y en ejecución.
*   (Opcional) Git para clonar el repositorio.

### 7.2 Despliegue con Docker (Recomendado)
Este método levanta todo el entorno (Frontend + Backend + BD) en un solo paso.

1.  **Navegar al directorio del proyecto:**
    ```bash
    cd empower
    ```

2.  **Iniciar los servicios:**
    *   **Windows:** Ejecutar `start.bat`
    *   **Linux/Mac:** Ejecutar `./start.sh`
    *   **Manual:** `docker-compose up --build`

3.  **Acceso:**
    *   Aplicación: [http://localhost](http://localhost)
    *   API Backend: [http://localhost:8080](http://localhost:8080) (accesible internamente vía proxy en puerto 80).

### 7.3 Configuración de Desarrollo Local (Sin Docker)
Para desarrollo activo sobre el código Flutter:

1.  Asegurar que backend y base de datos estén corriendo (puede usar XAMPP/WAMP o los contenedores solo de backend).
2.  Ejecutar Flutter:
    ```bash
    flutter pub get
    flutter run -d chrome
    ```

---

## 🐛 8. Troubleshooting y Mantenimiento

### 8.1 Problemas Comunes

**Conflicto de Puertos:**
Si el puerto 80 está ocupado, edite `docker-compose.yml`:
```yaml
frontend:
  ports:
    - "8081:80" # Cambiar 80 por 8081 u otro puerto libre
```

**Conexión a Base de Datos Fallida:**
Verifique que el contenedor `empower_mysql` esté saludable ("healthy"). Los scripts de espera en el backend deberían prevenir intentos de conexión prematuros.

### 8.2 Logs
Para ver los logs de ejecución en tiempo real:
```bash
docker-compose logs -f
```

---

## 🔒 9. Seguridad

*   **Hashing:** Todas las contraseñas se almacenan hasheadas utilizando el algoritmo estándar de PHP (`password_hash`).
*   **Validación:** Se implementan validaciones de entrada tanto en cliente (Dart) como en servidor (PHP) para prevenir inyección SQL y datos malformados.
*   **Aislamiento:** La base de datos no es accesible públicamente desde internet, solo desde la red interna de Docker y el host local.

---
**Fin del Documento**
