import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const ListoApp());
}

class ListoApp extends StatelessWidget {
  const ListoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LISTO! GO',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF5A1F),
        scaffoldBackgroundColor: Colors.grey[50],
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}
