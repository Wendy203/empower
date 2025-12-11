# 🚀 Inicio Rápido con Docker

## ⚡ Método 1: Scripts Automáticos (Recomendado)

### Windows:
```bash
start.bat
```

### Linux/Mac:
```bash
chmod +x start.sh
./start.sh
```

Esto construirá e iniciará automáticamente todos los servicios.

---

## 🛠️ Método 2: Comando Manual

```bash
docker-compose up --build
```

Para ejecutar en segundo plano:
```bash
docker-compose up -d --build
```

---

## 🌐 Acceder a la Aplicación

Una vez iniciados los contenedores:

- **Aplicación Web:** http://localhost
- **Backend API:** http://localhost:8080
- **Base de Datos:** localhost:3306

---

## 🔐 Credenciales de Prueba

**Usuario de prueba:**
- Email: `test@gmail.com`
- Contraseña: `test123`

O puedes registrar un nuevo usuario directamente desde la aplicación.

---

## ⏹️ Detener la Aplicación

### Windows:
```bash
stop.bat
```

### Linux/Mac:
```bash
./stop.sh
```

O manualmente:
```bash
docker-compose down
```

---

## 📖 Documentación Completa

Para más información, consulta: [DOCKER_SETUP.md](./DOCKER_SETUP.md)

---

## 🐛 Problemas Comunes

### Puerto 80 ocupado
Si el puerto 80 está en uso, edita `docker-compose.yml` y cambia:
```yaml
frontend:
  ports:
    - "8000:80"  # Cambia 80 a 8000
```

Luego accede en: http://localhost:8000

### Error de conexión al backend
Verifica que los 3 contenedores estén corriendo:
```bash
docker-compose ps
```

### Reconstruir desde cero
```bash
docker-compose down -v
docker-compose up --build
```

---

## 📊 Comandos Útiles

Ver logs en tiempo real:
```bash
docker-compose logs -f
```

Ver solo logs del frontend:
```bash
docker-compose logs -f frontend
```

Acceder a la base de datos:
```bash
docker exec -it empower_mysql mysql -u empower_user -pempower_pass_123 empower_db
```

---

## ✅ Checklist de Verificación

- [ ] Docker Desktop instalado y corriendo
- [ ] Puerto 80 disponible (o modificado en docker-compose.yml)
- [ ] Puerto 8080 disponible
- [ ] Al menos 5GB de espacio libre en disco
- [ ] Contenedores iniciados: `docker-compose ps`
- [ ] Aplicación accesible en http://localhost

---

**¡Listo!** Tu aplicación Empower está corriendo con Docker 🎉
