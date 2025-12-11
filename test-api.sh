#!/bin/bash

echo "========================================"
echo "   Probando API del Backend Empower"
echo "========================================"
echo ""

BACKEND_URL="http://localhost:8080"

echo "1. Verificando que el backend esté activo..."
curl -s $BACKEND_URL | jq .
echo ""
echo "---"
echo ""

echo "2. Probando Login con usuario de prueba..."
curl -s -X POST $BACKEND_URL/empower/login.php \
  -H "Content-Type: application/json" \
  -d '{"correo":"test@gmail.com","contrasena":"test123"}' | jq .
echo ""
echo "---"
echo ""

echo "3. Obteniendo puntos del usuario de prueba..."
curl -s -X POST $BACKEND_URL/empower/get_puntos.php \
  -H "Content-Type: application/json" \
  -d '{"correo":"test@gmail.com"}' | jq .
echo ""
echo "---"
echo ""

echo "4. Probando registro de nuevo usuario (ejemplo)..."
echo "(Descomenta las siguientes líneas para crear un usuario)"
# curl -s -X POST $BACKEND_URL/empower/register.php \
#   -H "Content-Type: application/json" \
#   -d '{
#     "nombre":"Nuevo",
#     "apellidos":"Usuario Test",
#     "escuela":"Instituto Tecnológico de Querétaro",
#     "correo":"nuevo@gmail.com",
#     "contrasena":"Test123"
#   }' | jq .
echo ""

echo "========================================"
echo "   Pruebas completadas"
echo "========================================"
