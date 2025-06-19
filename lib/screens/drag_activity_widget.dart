import 'package:flutter/material.dart';

class DragActivityWidget extends StatefulWidget {
  final VoidCallback onComplete;

  const DragActivityWidget({super.key, required this.onComplete});

  @override
  State<DragActivityWidget> createState() => _DragActivityWidgetState();
}

class _DragActivityWidgetState extends State<DragActivityWidget> {
  final Map<String, String> pairs = {
    "Phishing": "Correo falso",
    "Contraseña": "Clave segura",
    "Virus": "Malware",
  };

  final Map<String, bool> matched = {};

  @override
  void initState() {
    super.initState();
    for (var key in pairs.keys) {
      matched[key] = false;
    }
  }

  void _checkCompletion() {
    if (matched.values.every((e) => e)) {
  // Mostrar el diálogo antes de llamar a onComplete
  if (mounted) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("¡Felicidades!"),
        content: const Text("Completaste correctamente la actividad de arrastrar palabras."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);     // Cerrar el diálogo
              widget.onComplete();        // Luego marcar como completado
            },
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }
}

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Arrastra cada palabra a su definición correcta.",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Palabras
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pairs.keys.map((word) {
                  return Draggable<String>(
                    data: word,
                    feedback: Material(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.blue,
                        child: Text(word, style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                    childWhenDragging: const SizedBox(height: 40),
                    child: matched[word] == true
                        ? const SizedBox(height: 40)
                        : Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            color: Colors.blueAccent,
                            child: Text(word, style: const TextStyle(color: Colors.white)),
                          ),
                  );
                }).toList(),
              ),
              // Recuadros
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pairs.entries.map((entry) {
                  return DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        height: 60,
                        width: 180,
                        margin: const EdgeInsets.all(8),
                        color: matched[entry.key]! ? Colors.green[200] : Colors.grey[300],
                        alignment: Alignment.center,
                        child: Text(
                          matched[entry.key]! ? entry.key : entry.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                    onWillAccept: (data) => data == entry.key,
                    onAccept: (data) {
                      setState(() {
                        matched[entry.key] = true;
                      });
                      _checkCompletion();
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
