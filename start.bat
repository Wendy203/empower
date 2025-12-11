@echo off
echo ========================================
echo    Iniciando Empower con Docker
echo ========================================
echo.

echo Verificando Docker...
docker --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker no esta instalado o no esta en el PATH
    echo Por favor instala Docker Desktop desde: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

echo Docker encontrado!
echo.
echo Construyendo e iniciando los contenedores...
echo Esto puede tardar varios minutos la primera vez...
echo.

docker-compose up --build

pause
