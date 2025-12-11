<?php
/**
 * API Endpoint: Login de usuarios
 * Método: POST
 * Body: {"correo": "email@example.com", "contrasena": "password"}
 */

require_once '../config.php';

// Obtener datos JSON del request
$input = file_get_contents('php://input');
$data = json_decode($input, true);

// Validar que se recibieron los datos necesarios
if (!isset($data['correo']) || !isset($data['contrasena'])) {
    echo json_encode([
        "status" => "error",
        "message" => "Datos incompletos. Se requiere correo y contraseña."
    ]);
    exit();
}

$correo = trim($data['correo']);
$contrasena = trim($data['contrasena']);

// Validar formato de correo
if (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
    echo json_encode([
        "status" => "error",
        "message" => "Formato de correo inválido."
    ]);
    exit();
}

// Preparar consulta para buscar usuario
$stmt = $conn->prepare("SELECT id, nombre, apellidos, correo, contrasena FROM usuarios WHERE correo = ?");
$stmt->bind_param("s", $correo);
$stmt->execute();
$result = $stmt->get_result();

// Verificar si el usuario existe
if ($result->num_rows === 0) {
    echo json_encode([
        "status" => "error",
        "message" => "Usuario no encontrado. Verifica tu correo."
    ]);
    exit();
}

$usuario = $result->fetch_assoc();

// Verificar contraseña
// Nota: Para desarrollo, también aceptamos contraseña en texto plano para pruebas
$password_valida = password_verify($contrasena, $usuario['contrasena']) ||
                   ($contrasena === $usuario['contrasena']);

if (!$password_valida) {
    echo json_encode([
        "status" => "error",
        "message" => "Contraseña incorrecta."
    ]);
    exit();
}

// Login exitoso
echo json_encode([
    "status" => "success",
    "message" => "Inicio de sesión exitoso.",
    "usuario" => [
        "id" => $usuario['id'],
        "nombre" => $usuario['nombre'],
        "apellidos" => $usuario['apellidos'],
        "correo" => $usuario['correo']
    ]
]);

$stmt->close();
$conn->close();
?>
