import 'package:flutter/material.dart';
import 'screens/age_input_screen.dart';

void main() {
  runApp(const CiberseguridadApp());
}

class CiberseguridadApp extends StatelessWidget {
  const CiberseguridadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Ciberseguridad',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AgeInputScreen(),
    );
  }
}
