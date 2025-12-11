import 'package:flutter/material.dart';
import 'perfil_page.dart';
import 'login_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InicioPage extends StatefulWidget {
  final String correoUsuario;

  const InicioPage({Key? key, required this.correoUsuario}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  int plastico = 0;
  int carton = 0;
  int aluminio = 0;
  int total = 0;
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerPuntos();
  }

  void obtenerPuntos() async {
    try {
      var url = Uri.parse("http://localhost/empower/get_puntos.php");
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"correo": widget.correoUsuario}),
      );

      var data = jsonDecode(response.body);
      print("RESPUESTA PHP: ${data}");

      if (data["status"] == "success") {
        setState(() {
          plastico = data["plastico"];
          carton = data["carton"];
          aluminio = data["aluminio"];
          total = data["total"];
          cargando = false;
        });
      } else {
        setState(() {
          cargando = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"])),
        );
      }
    } catch (e) {
      setState(() {
        cargando = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al obtener puntos")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMPOWER"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PerfilPage(correoUsuario: widget.correoUsuario),
                ),
              );
            },
          )
        ],
      ),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset('assets/imagenes/logo.png', height: 100),
                  SizedBox(height: 20),
                  Text(
                    "Puntos obtenidos por material",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Card(
                      child: ListTile(
                          title: Text("Plástico"),
                          trailing: Text("$plastico pts"))),
                  Card(
                      child: ListTile(
                          title: Text("Cartón"), trailing: Text("$carton pts"))),
                  Card(
                      child: ListTile(
                          title: Text("Aluminio"),
                          trailing: Text("$aluminio pts"))),
                  SizedBox(height: 20),
                  Text(
                    "Total: $total pts",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    icon: Icon(Icons.logout),
                    label: Text("Cerrar sesión"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
