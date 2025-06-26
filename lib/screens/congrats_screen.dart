import 'package:flutter/material.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("¡Felicidades!")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "🎉 Felicidades 🎉\nHas completado las 10 actividades.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              "Ahora necesitamos que nos des tu retroalimentación.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes navegar a un formulario o cerrar app
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Volver al inicio"),
            )
          ],
        ),
      ),
    );
  }
}
