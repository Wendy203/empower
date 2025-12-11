import 'package:flutter/material.dart';

class ConfiguracionPage extends StatefulWidget {
  final String correoUsuario;
  const ConfiguracionPage({Key? key, required this.correoUsuario}) : super(key: key);

  @override
  _ConfiguracionPageState createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  bool notificaciones = true;
  bool modoOscuro = false;

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
          Text(
            'Preferencias',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Card(
            child: SwitchListTile(
              title: Text('Notificaciones'),
              subtitle: Text('Recibir alertas de puntos y recompensas'),
              value: notificaciones,
              onChanged: (bool value) {
                setState(() {
                  notificaciones = value;
                });
              },
              secondary: Icon(Icons.notifications),
            ),
          ),
          Card(
            child: SwitchListTile(
              title: Text('Modo oscuro'),
              subtitle: Text('Cambiar el tema de la aplicación'),
              value: modoOscuro,
              onChanged: (bool value) {
                setState(() {
                  modoOscuro = value;
                });
              },
              secondary: Icon(Icons.dark_mode),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Cuenta',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.email),
              title: Text('Correo electrónico'),
              subtitle: Text(widget.correoUsuario),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.lock),
              title: Text('Cambiar contraseña'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Función en desarrollo')),
                );
              },
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Información',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text('Acerca de'),
              subtitle: Text('Empower v1.0.0'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.help),
              title: Text('Ayuda y soporte'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Función en desarrollo')),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Política de privacidad'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Función en desarrollo')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
