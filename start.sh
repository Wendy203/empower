#!/bin/bash

echo "========================================"
echo "   Iniciando Empower con Docker"
echo "========================================"
echo ""

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "[ERROR] Docker no está instalado"
    echo "Por favor instala Docker desde: https://www.docker.com/get-started"
    exit 1
fi

# Verificar si Docker Compose está instalado
if ! command -v docker-compose &> /dev/null; then
    echo "[ERROR] Docker Compose no está instalado"
    echo "Por favor instala Docker Compose desde: https://docs.docker.com/compose/install/"
    exit 1
fi

echo "Docker encontrado!"
echo ""
echo "Construyendo e iniciando los contenedores..."
echo "Esto puede tardar varios minutos la primera vez..."
echo ""

# Ejecutar docker-compose
docker-compose up --build

echo ""
echo "Aplicación detenida."
