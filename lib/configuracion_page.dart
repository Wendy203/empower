import 'package:flutter/material.dart';

class ConfiguracionPage extends StatelessWidget {
  final String correoUsuario;
  const ConfiguracionPage({Key? key, required this.correoUsuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.email),
              title: Text('Correo electrónico'),
              subtitle: Text(correoUsuario),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notificaciones'),
              subtitle: Text('Gestionar notificaciones'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.lock),
              title: Text('Cambiar contraseña'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text('Acerca de'),
              subtitle: Text('Empower v1.0.0'),
            ),
          ),
        ],
      ),
    );
  }
}
