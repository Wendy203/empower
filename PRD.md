# PRD - Empower
## Documento de Requisitos de Producto

**Versión:** 1.0.0
**Fecha:** Diciembre 2025
**Producto:** Empower - Sistema de gamificación para reciclaje

---

## 1. VISIÓN DEL PRODUCTO

Empower es una aplicación móvil que incentiva el reciclaje en instituciones educativas mediante un sistema de puntos. Los usuarios pueden registrar sus actividades de reciclaje y acumular puntos por material reciclado.

---

## 2. OBJETIVOS DEL NEGOCIO

- Fomentar la cultura del reciclaje en estudiantes
- Gamificar el proceso de reciclaje para hacerlo más atractivo
- Rastrear y medir el impacto ambiental individual
- Crear un sistema escalable y simple de implementar

---

## 3. USUARIOS OBJETIVO

**Perfil principal:** Estudiantes de instituciones educativas

**Características:**
- Edad: 15-25 años
- Uso frecuente de dispositivos móviles
- Interés en sostenibilidad ambiental
- Motivados por gamificación y recompensas

---

## 4. FUNCIONALIDADES PRINCIPALES

### 4.1 Autenticación de Usuarios

#### Registro
**Descripción:** El usuario puede crear una cuenta nueva

**Datos requeridos:**
- Nombre
- Apellidos
- Institución educativa
- Correo electrónico
- Contraseña

**Reglas de negocio:**
- El correo debe ser único en el sistema
- Solo se permiten correos de dominios educativos o gmail
- La contraseña debe tener entre 6-10 caracteres
- La contraseña debe contener al menos: 1 mayúscula, 1 minúscula, 1 número
- Al registrarse, el usuario inicia con 0 puntos en todos los materiales

#### Inicio de Sesión
**Descripción:** El usuario accede con sus credenciales

**Datos requeridos:**
- Correo electrónico
- Contraseña

**Reglas de negocio:**
- Las credenciales deben coincidir con un usuario registrado
- El sistema valida la contraseña de forma segura

### 4.2 Sistema de Puntos

#### Tipos de Materiales
El sistema maneja **3 categorías de materiales reciclables:**

1. **Plástico**
2. **Cartón**
3. **Aluminio**

#### Acumulación de Puntos
**Descripción:** Los usuarios acumulan puntos por cada tipo de material que reciclan

**Reglas de negocio:**
- Cada material tiene su propio contador de puntos independiente
- Los puntos se acumulan de forma individual por categoría
- El sistema calcula automáticamente el total sumando todos los materiales
- Los puntos son siempre números enteros positivos
- Los puntos nunca disminuyen (no hay penalizaciones)

#### Visualización de Puntos
**Descripción:** Los usuarios pueden ver su progreso

**Información mostrada:**
- Puntos por plástico
- Puntos por cartón
- Puntos por aluminio
- Total de puntos acumulados

### 4.3 Perfil de Usuario

**Descripción:** Cada usuario tiene un perfil con su información

**Datos visibles:**
- Correo electrónico del usuario
- Puntos acumulados (visible desde pantalla principal)

**Acciones disponibles:**
- Ver configuración
- Cerrar sesión

### 4.4 Configuración

**Descripción:** Pantalla informativa con opciones básicas

**Información mostrada:**
- Correo electrónico
- Versión de la aplicación
- Opciones de notificaciones (placeholder)
- Opción de cambiar contraseña (placeholder)

---

## 5. FLUJOS DE USUARIO

### Flujo 1: Primer uso de la aplicación

```
1. Usuario abre la app por primera vez
2. Ve pantalla de login
3. Hace clic en "Registrarse"
4. Completa formulario de registro
5. Sistema crea cuenta con 0 puntos
6. Usuario regresa a login
7. Ingresa sus credenciales
8. Accede a pantalla principal
9. Ve sus puntos (todos en 0)
```

### Flujo 2: Usuario recurrente

```
1. Usuario abre la app
2. Ingresa correo y contraseña
3. Sistema valida credenciales
4. Usuario ve pantalla principal
5. Sistema carga y muestra sus puntos actuales
6. Usuario puede navegar a su perfil
7. Usuario puede cerrar sesión
```

### Flujo 3: Consulta de puntos

```
1. Usuario está autenticado
2. Entra a pantalla principal
3. Sistema consulta puntos del usuario
4. Se muestran puntos por categoría:
   - Plástico: X puntos
   - Cartón: X puntos
   - Aluminio: X puntos
   - Total: X puntos
5. Usuario ve su progreso actual
```

---

## 6. REGLAS DE NEGOCIO PRINCIPALES

### 6.1 Gestión de Usuarios

1. **Unicidad de correo:** No pueden existir dos usuarios con el mismo correo
2. **Formato de correo:** Solo se aceptan correos válidos de dominios específicos
3. **Seguridad de contraseña:** Las contraseñas se almacenan de forma segura (hasheadas)
4. **Datos obligatorios:** Todos los campos del registro son requeridos

### 6.2 Sistema de Puntos

1. **Inicialización:** Todos los usuarios nuevos comienzan con 0 puntos
2. **Categorías independientes:** Los puntos de cada material se manejan por separado
3. **Suma automática:** El total se calcula automáticamente sumando todas las categorías
4. **Solo crecimiento:** Los puntos solo pueden aumentar, nunca disminuir
5. **Persistencia:** Los puntos se mantienen aunque el usuario cierre sesión

### 6.3 Validaciones de Datos

**Nombre y apellidos:**
- Solo letras permitidas
- Mínimo 2 caracteres
- Pueden contener espacios y caracteres acentuados

**Institución educativa:**
- Campo obligatorio
- Texto libre

**Correo electrónico:**
- Formato válido de email
- Dominios permitidos: gmail.com, queretaro.tecnm.mx
- Debe ser único en el sistema

**Contraseña:**
- Longitud: 6-10 caracteres
- Debe contener al menos una letra mayúscula
- Debe contener al menos una letra minúscula
- Debe contener al menos un número

---

## 7. MODELO DE DATOS

### 7.1 Entidad: Usuario

| Campo | Tipo | Descripción |
|-------|------|-------------|
| ID | Número | Identificador único |
| Nombre | Texto | Nombre del usuario |
| Apellidos | Texto | Apellidos del usuario |
| Escuela | Texto | Institución educativa |
| Correo | Texto | Email (único) |
| Contraseña | Texto | Contraseña segura |
| Fecha de registro | Fecha/Hora | Cuándo se registró |

### 7.2 Entidad: Puntos

| Campo | Tipo | Descripción |
|-------|------|-------------|
| ID | Número | Identificador único |
| Usuario | Referencia | A qué usuario pertenece |
| Plástico | Número | Puntos por plástico |
| Cartón | Número | Puntos por cartón |
| Aluminio | Número | Puntos por aluminio |
| Total | Número | Suma de todos los puntos |
| Última actualización | Fecha/Hora | Cuándo se modificó |

### 7.3 Relación

- Un usuario tiene exactamente un registro de puntos
- Si se elimina un usuario, se eliminan sus puntos

---

## 8. PANTALLAS DE LA APLICACIÓN

### Pantalla 1: Login
**Propósito:** Autenticar usuarios existentes

**Elementos:**
- Logo de la aplicación
- Campo: Correo electrónico
- Campo: Contraseña
- Botón: Acceder
- Enlace: Registrarse

### Pantalla 2: Registro
**Propósito:** Crear nuevas cuentas

**Elementos:**
- Logo de la aplicación
- Campo: Nombre
- Campo: Apellidos
- Campo: Institución educativa
- Campo: Correo electrónico
- Campo: Contraseña
- Campo: Confirmar contraseña
- Botón: Registrar
- Enlace: Volver al inicio de sesión

### Pantalla 3: Inicio (Principal)
**Propósito:** Mostrar puntos acumulados

**Elementos:**
- Barra superior con botón de perfil
- Logo de la aplicación
- Tarjeta: Puntos de plástico
- Tarjeta: Puntos de cartón
- Tarjeta: Puntos de aluminio
- Texto: Total de puntos
- Botón: Cerrar sesión

### Pantalla 4: Perfil
**Propósito:** Ver información del usuario

**Elementos:**
- Ícono de perfil
- Correo del usuario
- Opción: Configuración
- Opción: Cerrar sesión

### Pantalla 5: Configuración
**Propósito:** Información y ajustes básicos

**Elementos:**
- Información: Correo electrónico
- Opción: Notificaciones
- Opción: Cambiar contraseña
- Información: Versión de la app

---

## 9. COMUNICACIÓN CON EL SERVIDOR

### 9.1 Operación: Registrar usuario

**Datos enviados:**
- Nombre
- Apellidos
- Institución educativa
- Correo
- Contraseña

**Proceso:**
1. Sistema valida datos
2. Verifica que el correo no exista
3. Guarda usuario en base de datos
4. Crea registro de puntos en 0
5. Confirma registro exitoso

**Resultado:**
- Usuario creado y listo para iniciar sesión

### 9.2 Operación: Iniciar sesión

**Datos enviados:**
- Correo
- Contraseña

**Proceso:**
1. Sistema busca usuario por correo
2. Valida contraseña
3. Retorna información del usuario

**Resultado:**
- Usuario autenticado y accede a la app

### 9.3 Operación: Obtener puntos

**Datos enviados:**
- Correo del usuario

**Proceso:**
1. Sistema busca al usuario
2. Consulta sus puntos actuales
3. Retorna puntos por categoría y total

**Resultado:**
- Puntos mostrados en pantalla

---

## 10. CRITERIOS DE ÉXITO

### Funcionales
- ✅ Un usuario puede registrarse correctamente
- ✅ Un usuario puede iniciar sesión
- ✅ Un usuario puede ver sus puntos acumulados
- ✅ Los puntos se muestran por categoría y total
- ✅ Un usuario puede cerrar sesión
- ✅ Los datos persisten entre sesiones

### No Funcionales
- El registro debe completarse en menos de 5 segundos
- El login debe completarse en menos de 3 segundos
- La carga de puntos debe ser inmediata (menos de 2 segundos)
- La aplicación debe funcionar sin conexión a internet para consultar datos ya cargados (opcional)
- La interfaz debe ser simple e intuitiva

---

## 11. LIMITACIONES Y ALCANCE

### Dentro del alcance (versión 1.0)
- ✅ Registro de usuarios
- ✅ Inicio de sesión
- ✅ Visualización de puntos
- ✅ Navegación básica (perfil, configuración)
- ✅ Cierre de sesión

### Fuera del alcance (versión 1.0)
- ❌ Registro de actividades de reciclaje
- ❌ Agregar/sumar puntos
- ❌ Canje de puntos por recompensas
- ❌ Historial de transacciones
- ❌ Ranking entre usuarios
- ❌ Notificaciones push
- ❌ Cambio de contraseña
- ❌ Recuperación de contraseña
- ❌ Edición de perfil
- ❌ Subir evidencias fotográficas
- ❌ Mapa de centros de reciclaje
- ❌ Estadísticas gráficas

### Funcionalidades futuras (roadmap)
1. **Versión 1.1:** Registro de reciclaje y suma de puntos
2. **Versión 1.2:** Sistema de recompensas y canje
3. **Versión 1.3:** Ranking y competencias
4. **Versión 2.0:** Funcionalidades sociales y comunidad

---

## 12. SUPUESTOS Y DEPENDENCIAS

### Supuestos
- Los usuarios tienen acceso a un dispositivo móvil
- Los usuarios tienen conexión a internet
- Las instituciones educativas apoyan la iniciativa
- Los usuarios están motivados por puntos y gamificación

### Dependencias
- Disponibilidad de servidor para alojar la base de datos
- Disponibilidad de servidor para alojar la API
- Mantenimiento básico de infraestructura

---

## 13. SEGURIDAD Y PRIVACIDAD

### Medidas de seguridad
1. **Contraseñas:** Se almacenan de forma segura (hasheadas, no en texto plano)
2. **Validaciones:** Todos los datos se validan antes de guardarse
3. **Correos únicos:** No puede haber duplicados
4. **Acceso restringido:** Solo el usuario puede ver sus propios puntos

### Datos personales almacenados
- Nombre y apellidos
- Institución educativa
- Correo electrónico
- Contraseña (hasheada)
- Puntos de reciclaje

### Privacidad
- Los datos del usuario son confidenciales
- Solo el usuario puede ver su información
- No se comparten datos con terceros

---

## 14. MÉTRICAS DE ÉXITO DEL PRODUCTO

### Adopción
- Número de usuarios registrados
- Tasa de registro completado vs iniciado
- Porcentaje de usuarios que regresan a la app

### Engagement
- Frecuencia de inicio de sesión
- Tiempo promedio en la aplicación
- Pantallas más visitadas

### Impacto (para versiones futuras)
- Total de puntos acumulados en el sistema
- Material más reciclado
- Tendencia de crecimiento de puntos

---

## 15. GLOSARIO

- **Usuario:** Estudiante registrado en la aplicación
- **Puntos:** Unidad de medida del reciclaje acumulado
- **Material:** Categoría de residuo reciclable (plástico, cartón, aluminio)
- **Total:** Suma de puntos de todas las categorías
- **Sesión:** Periodo desde que el usuario hace login hasta logout
- **Autenticación:** Proceso de verificar identidad (login)
- **Registro:** Proceso de crear una cuenta nueva

---

## 16. PREGUNTAS FRECUENTES

**P: ¿Cómo se agregan puntos a un usuario?**
R: En la versión 1.0, los puntos solo se pueden consultar. La funcionalidad para agregar puntos está planificada para la versión 1.1.

**P: ¿Qué pasa si un usuario olvida su contraseña?**
R: En la versión 1.0 no hay recuperación de contraseña. Esta funcionalidad se agregará en versiones futuras.

**P: ¿Los usuarios pueden ver los puntos de otros?**
R: No, cada usuario solo puede ver sus propios puntos.

**P: ¿Cómo se calcula cuántos puntos vale cada material?**
R: El cálculo de puntos por cantidad de material se definirá en la versión 1.1 cuando se implemente el registro de reciclaje.

**P: ¿Qué instituciones educativas pueden usar la app?**
R: Actualmente está configurada para aceptar correos de @queretaro.tecnm.mx y @gmail.com, pero puede extenderse a cualquier institución.

---

## RESUMEN EJECUTIVO

**Empower v1.0** es un MVP (Producto Mínimo Viable) que establece la base de un sistema de gamificación para reciclaje.

**Funcionalidad principal:** Permite a estudiantes crear una cuenta, iniciar sesión, y ver sus puntos acumulados por material reciclado.

**Próximos pasos:** Implementar la funcionalidad core de registro de reciclaje y suma de puntos para completar el ciclo de valor del producto.

**Propuesta de valor:** Sistema simple y escalable que incentiva el reciclaje mediante puntos, sentando las bases para un programa completo de sostenibilidad en instituciones educativas.
