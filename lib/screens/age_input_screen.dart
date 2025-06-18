import 'package:flutter/material.dart';
import 'activity_list_screen.dart';

class AgeInputScreen extends StatefulWidget {
  const AgeInputScreen({super.key});

  @override
  State<AgeInputScreen> createState() => _AgeInputScreenState();
}

class _AgeInputScreenState extends State<AgeInputScreen> {
  final TextEditingController _ageController = TextEditingController();

  void _continue() {
    final age = int.tryParse(_ageController.text);
    if (age != null && age > 0) {
      int group = age < 10 ? 0 : (age <= 50 ? 1 : 2);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ActivityListScreen(group: group)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ingrese su edad")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("¿Cuál es tu edad?", style: TextStyle(fontSize: 18)),
            TextField(controller: _ageController, keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _continue, child: const Text("Continuar"))
          ],
        ),
      ),
    );
  }
}