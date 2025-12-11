@echo off
echo ========================================
echo    Probando API del Backend Empower
echo ========================================
echo.

set BACKEND_URL=http://localhost:8080

echo 1. Verificando que el backend este activo...
curl -s %BACKEND_URL%
echo.
echo ---
echo.

echo 2. Probando Login con usuario de prueba...
curl -s -X POST %BACKEND_URL%/empower/login.php -H "Content-Type: application/json" -d "{\"correo\":\"test@gmail.com\",\"contrasena\":\"test123\"}"
echo.
echo ---
echo.

echo 3. Obteniendo puntos del usuario de prueba...
curl -s -X POST %BACKEND_URL%/empower/get_puntos.php -H "Content-Type: application/json" -d "{\"correo\":\"test@gmail.com\"}"
echo.
echo ---
echo.

echo ========================================
echo    Pruebas completadas
echo ========================================
pause
