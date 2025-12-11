<?php
/**
 * Configuración de conexión a la base de datos
 */

// Configuración desde variables de entorno (Docker)
$db_host = getenv('DB_HOST') ?: 'database';
$db_name = getenv('DB_NAME') ?: 'empower_db';
$db_user = getenv('DB_USER') ?: 'empower_user';
$db_password = getenv('DB_PASSWORD') ?: 'empower_pass_123';

// Crear conexión MySQLi
$conn = new mysqli($db_host, $db_user, $db_password, $db_name);

// Verificar conexión
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Error de conexión a la base de datos"
    ]);
    exit();
}

// Configurar charset
$conn->set_charset("utf8mb4");

// Headers para CORS
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=utf-8');

// Manejar preflight OPTIONS
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}
?>
