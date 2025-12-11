<?php
/**
 * Página de inicio del backend Empower
 * Muestra información sobre la API y estado del servidor
 */

header('Content-Type: application/json; charset=utf-8');

echo json_encode([
    "status" => "success",
    "message" => "Backend Empower API está funcionando correctamente",
    "version" => "1.0.0",
    "endpoints" => [
        "/empower/login.php" => "POST - Iniciar sesión (correo, contrasena)",
        "/empower/register.php" => "POST - Registrar usuario (nombre, apellidos, escuela, correo, contrasena)",
        "/empower/get_puntos.php" => "POST - Obtener puntos de reciclaje (correo)"
    ],
    "timestamp" => date('Y-m-d H:i:s')
], JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
?>
