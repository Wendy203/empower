<?php
/**
 * API Endpoint: Registro de nuevos usuarios
 * Método: POST
 * Body: {"nombre": "...", "apellidos": "...", "escuela": "...", "correo": "...", "contrasena": "..."}
 */

require_once '../config.php';

// Obtener datos JSON del request
$input = file_get_contents('php://input');
$data = json_decode($input, true);

// Validar que se recibieron todos los datos necesarios
$campos_requeridos = ['nombre', 'apellidos', 'escuela', 'correo', 'contrasena'];
foreach ($campos_requeridos as $campo) {
    if (!isset($data[$campo]) || empty(trim($data[$campo]))) {
        echo json_encode([
            "status" => "error",
            "message" => "Datos incompletos. Campo requerido: $campo"
        ]);
        exit();
    }
}

$nombre = trim($data['nombre']);
$apellidos = trim($data['apellidos']);
$escuela = trim($data['escuela']);
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

// Validar dominios permitidos
$dominios_permitidos = ['gmail.com', 'queretaro.tecnm.mx'];
$dominio = substr(strrchr($correo, "@"), 1);
if (!in_array($dominio, $dominios_permitidos)) {
    echo json_encode([
        "status" => "error",
        "message" => "Solo se permiten correos de @gmail.com o @queretaro.tecnm.mx"
    ]);
    exit();
}

// Validar requisitos de contraseña (6-10 caracteres, mayúscula, minúscula, número)
if (strlen($contrasena) < 6 || strlen($contrasena) > 10) {
    echo json_encode([
        "status" => "error",
        "message" => "La contraseña debe tener entre 6 y 10 caracteres."
    ]);
    exit();
}

if (!preg_match('/[A-Z]/', $contrasena) || !preg_match('/[a-z]/', $contrasena) || !preg_match('/[0-9]/', $contrasena)) {
    echo json_encode([
        "status" => "error",
        "message" => "La contraseña debe contener al menos una mayúscula, una minúscula y un número."
    ]);
    exit();
}

// Verificar si el correo ya está registrado
$stmt = $conn->prepare("SELECT id FROM usuarios WHERE correo = ?");
$stmt->bind_param("s", $correo);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    echo json_encode([
        "status" => "error",
        "message" => "Este correo ya está registrado. Intenta iniciar sesión."
    ]);
    exit();
}
$stmt->close();

// Encriptar contraseña
$contrasena_hash = password_hash($contrasena, PASSWORD_DEFAULT);

// Insertar nuevo usuario
$stmt = $conn->prepare("INSERT INTO usuarios (nombre, apellidos, escuela, correo, contrasena) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("sssss", $nombre, $apellidos, $escuela, $correo, $contrasena_hash);

if (!$stmt->execute()) {
    echo json_encode([
        "status" => "error",
        "message" => "Error al registrar usuario. Intenta nuevamente."
    ]);
    exit();
}

$usuario_id = $stmt->insert_id;
$stmt->close();

// Crear registro de puntos inicial para el nuevo usuario
$stmt = $conn->prepare("INSERT INTO puntos (usuario_id, plastico, carton, aluminio, total) VALUES (?, 0, 0, 0, 0)");
$stmt->bind_param("i", $usuario_id);
$stmt->execute();
$stmt->close();

// Registro exitoso
echo json_encode([
    "status" => "success",
    "message" => "Usuario registrado exitosamente. Ya puedes iniciar sesión.",
    "usuario_id" => $usuario_id
]);

$conn->close();
?>
