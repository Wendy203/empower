<?php
/**
 * API Endpoint: Obtener puntos de reciclaje de un usuario
 * Método: POST
 * Body: {"correo": "email@example.com"}
 */

require_once '../config.php';

// Obtener datos JSON del request
$input = file_get_contents('php://input');
$data = json_decode($input, true);

// Validar que se recibió el correo
if (!isset($data['correo']) || empty(trim($data['correo']))) {
    echo json_encode([
        "status" => "error",
        "message" => "Se requiere el correo del usuario."
    ]);
    exit();
}

$correo = trim($data['correo']);

// Buscar usuario y sus puntos
$stmt = $conn->prepare("
    SELECT u.id, u.nombre, u.correo, p.plastico, p.carton, p.aluminio, p.total
    FROM usuarios u
    LEFT JOIN puntos p ON u.id = p.usuario_id
    WHERE u.correo = ?
");
$stmt->bind_param("s", $correo);
$stmt->execute();
$result = $stmt->get_result();

// Verificar si el usuario existe
if ($result->num_rows === 0) {
    echo json_encode([
        "status" => "error",
        "message" => "Usuario no encontrado."
    ]);
    exit();
}

$datos = $result->fetch_assoc();

// Si no tiene registro de puntos, crearlo
if ($datos['plastico'] === null) {
    $stmt_insert = $conn->prepare("INSERT INTO puntos (usuario_id, plastico, carton, aluminio, total) VALUES (?, 0, 0, 0, 0)");
    $stmt_insert->bind_param("i", $datos['id']);
    $stmt_insert->execute();
    $stmt_insert->close();

    $datos['plastico'] = 0;
    $datos['carton'] = 0;
    $datos['aluminio'] = 0;
    $datos['total'] = 0;
}

// Retornar puntos
echo json_encode([
    "status" => "success",
    "plastico" => (int)$datos['plastico'],
    "carton" => (int)$datos['carton'],
    "aluminio" => (int)$datos['aluminio'],
    "total" => (int)$datos['total']
]);

$stmt->close();
$conn->close();
?>
