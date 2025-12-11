import 'package:flutter/material.dart';
import 'inicio_page.dart';
import 'registro_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  void _login() async {
  if (!_formKey.currentState!.validate()) return;

  try {
    var url = Uri.parse("http://localhost/empower/login.php");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "correo": _correoController.text.trim(),
        "contrasena": _contrasenaController.text.trim(),
      }),
    );

    print("RESPUESTA PHP LOGIN: ${response.body}");

    // Validar que la respuesta sea JSON
    var data;
    try {
      data = jsonDecode(response.body);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: respuesta del servidor no es JSON válido.")),
      );
      return;
    }

    if (data["status"] == "success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InicioPage(correoUsuario: _correoController.text.trim()),

      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["message"])),
      );
    }
  } catch (e) {
    // Error de conexión
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("No se pudo conectar con el servidor")),
    );
    print("ERROR LOGIN: $e");
  }
}

  String? _validarCorreo(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa tu correo';
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) return 'Correo inválido';
    return null;
  }

  String? _validarContrasena(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa tu contraseña';
    if (value.length < 4) return 'La contraseña debe tener al menos 4 caracteres';
    return null;
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
            Text('EMPOWER',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              'Bienvenido, inicia sesión para comenzar a reciclar y ganar puntos.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Text('Acceder'),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
  onPressed: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegistroPage()),
    );
  },
  child: Text('Registrarse', style: TextStyle(fontSize: 16)),
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
