import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _escuelaController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _confirmarController = TextEditingController();

  final RegExp _soloLetras = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$');

  String? _validarNombre(String? value) {
    if (value == null || value.trim().isEmpty) return 'Ingresa tu nombre';
    if (!_soloLetras.hasMatch(value.trim())) return 'Solo se permiten letras';
    if (value.trim().length < 2) return 'Nombre muy corto';
    return null;
  }

  String? _validarApellidos(String? value) {
    if (value == null || value.trim().isEmpty) return 'Ingresa tus apellidos';
    if (!_soloLetras.hasMatch(value.trim())) return 'Solo se permiten letras';
    if (value.trim().length < 2) return 'Apellidos muy cortos';
    return null;
  }

  String? _validarCorreo(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa un correo válido';
    final regex = RegExp(r'^[^@]+@(gmail\.com|queretaro\.tecnm\.mx)$');
    if (!regex.hasMatch(value)) {
      return 'Usa correo @gmail.com o @queretaro.tecnm.mx';
    }
    return null;
  }

  String? _validarContrasena(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa una contraseña';
    final regex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,10}$');
    if (!regex.hasMatch(value)) {
      return 'Debe tener 6-10 caracteres, mayúscula, minúscula y número';
    }
    return null;
  }

  // 🔥 FUNCIÓN QUE ENVÍA JSON A PHP
  void _registrar() async {
    if (!_formKey.currentState!.validate()) return;

    if (_contrasenaController.text != _confirmarController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

var url = Uri.parse("http://localhost/empower/register.php");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nombre": _nombreController.text.trim(),
        "apellidos": _apellidosController.text.trim(),
        "escuela": _escuelaController.text.trim(),
        "correo": _correoController.text.trim(),
        "contrasena": _contrasenaController.text.trim(),
      }),
    );

    print("RESPUESTA DESDE PHP: ${response.body}");

    var data = jsonDecode(response.body);

    if (data["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registro exitoso")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["message"])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 60),
            Image.asset('assets/imagenes/logo.png', height: 100),
            SizedBox(height: 20),
            Text(
              'EMPOWER',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Crea tu cuenta para comenzar a reciclar y ganar puntos.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: _validarNombre,
                  ),
                  SizedBox(height: 15),

                  TextFormField(
                    controller: _apellidosController,
                    decoration: InputDecoration(
                      labelText: 'Apellidos',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: _validarApellidos,
                  ),
                  SizedBox(height: 15),

                  TextFormField(
                    controller: _escuelaController,
                    decoration: InputDecoration(
                      labelText: 'Institución Educativa',
                      prefixIcon: Icon(Icons.school),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Ingresa tu escuela' : null,
                  ),
                  SizedBox(height: 15),

                  TextFormField(
                    controller: _correoController,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: _validarCorreo,
                  ),
                  SizedBox(height: 15),

                  TextFormField(
                    controller: _contrasenaController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                    validator: _validarContrasena,
                  ),
                  SizedBox(height: 15),

                  TextFormField(
                    controller: _confirmarController,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Contraseña',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                    validator: _validarContrasena,
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _registrar,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      child: Text('Registrar'),
                    ),
                  ),
                  SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Volver al inicio de sesión',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
