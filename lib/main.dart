import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(EmpowerApp());
}

class EmpowerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empower',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
