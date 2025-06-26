import 'package:flutter/material.dart';
import 'activity_list_screen.dart';

class AgeInputScreen extends StatefulWidget {
  const AgeInputScreen({super.key});

  @override
  State<AgeInputScreen> createState() => _AgeInputScreenState();
}

class _AgeInputScreenState extends State<AgeInputScreen> {
  final TextEditingController _ageController = TextEditingController();

  void _submit() {
    final age = int.tryParse(_ageController.text);

    if (age == null) {
      _showError("Por favor, ingrese una edad válida.");
      return;
    }

    int? group;

    if (age >= 8 && age <= 11) {
      group = 0;
    } else if (age >= 12 && age <= 18) {
      group = 1;
    } else if (age >= 65 && age <= 99) {
      group = 2;
    }

    if (group != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ActivityListScreen(group: group!), // ¡corregido!
        ),
      );
    } else {
      _showError("Edad fuera de rango. Ingrese una edad entre 8 y 99 años.");
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ingrese su edad")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Edad",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text("Continuar"),
            ),
          ],
        ),
      ),
    );
  }
}
