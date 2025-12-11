-- Script de inicialización de la base de datos Empower

CREATE DATABASE IF NOT EXISTS empower_db;
USE empower_db;

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    escuela VARCHAR(200) NOT NULL,
    correo VARCHAR(150) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_correo (correo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de puntos de reciclaje
CREATE TABLE IF NOT EXISTS puntos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    plastico INT DEFAULT 0,
    carton INT DEFAULT 0,
    aluminio INT DEFAULT 0,
    total INT DEFAULT 0,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_usuario (usuario_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Datos de ejemplo para pruebas
INSERT INTO usuarios (nombre, apellidos, escuela, correo, contrasena) VALUES
('Juan', 'Pérez García', 'Instituto Tecnológico de Querétaro', 'juan.perez@queretaro.tecnm.mx', '$2y$10$YourHashedPasswordHere'),
('María', 'López Hernández', 'Instituto Tecnológico de Querétaro', 'maria.lopez@gmail.com', '$2y$10$YourHashedPasswordHere');

-- Puntos iniciales para los usuarios de ejemplo
INSERT INTO puntos (usuario_id, plastico, carton, aluminio, total) VALUES
(1, 150, 200, 100, 450),
(2, 80, 120, 50, 250);

-- Usuario de prueba: test@gmail.com con contraseña: test123
-- Hash generado con password_hash('test123', PASSWORD_DEFAULT)
INSERT INTO usuarios (nombre, apellidos, escuela, correo, contrasena) VALUES
('Usuario', 'De Prueba', 'Instituto Tecnológico de Querétaro', 'test@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

INSERT INTO puntos (usuario_id, plastico, carton, aluminio, total) VALUES
(3, 300, 400, 200, 900);
