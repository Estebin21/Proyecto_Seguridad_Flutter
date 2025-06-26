import 'package:flutter/material.dart';

class DragActivityWidget extends StatefulWidget {
  final VoidCallback onComplete;
  final Map<String, String> pairs;

  const DragActivityWidget({
    super.key,
    required this.onComplete,
    required this.pairs,
  });

  @override
  State<DragActivityWidget> createState() => _DragActivityWidgetState();
}

class _DragActivityWidgetState extends State<DragActivityWidget> {
  late final Map<String, String?> answers;

  @override
  void initState() {
    super.initState();
    answers = {for (var key in widget.pairs.keys) key: null};
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(  // Hacer que la pantalla sea desplazable
      child: Column(
        children: [
          const Text(
            "Arrastra cada palabra a su definición correcta.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Usar Column y Expanded para evitar overflow y distribuir el contenido
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Columna para las palabras a arrastrar
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pairs.keys.map((word) {
                  if (answers[word] == word) return const SizedBox(height: 40);
                  return Draggable<String>(
                    data: word,
                    feedback: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.blue,
                        child: Text(word, style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                    childWhenDragging: const SizedBox(height: 40),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      color: Colors.blueAccent,
                      child: Text(word, style: const TextStyle(color: Colors.white)),
                    ),
                  );
                }).toList(),
              ),
              // Columna para los objetivos donde soltar las palabras
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pairs.entries.map((entry) {
                  final key = entry.key;
                  final expected = entry.value;
                  final received = answers[key];
                  final isCorrect = received == key;

                  return DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        height: 60,
                        width: 160,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isCorrect ? Colors.green[200] : Colors.grey[300],
                          border: Border.all(color: Colors.black),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          expected,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                    onAccept: (data) {
                      setState(() {
                        answers[key] = data;

                        // Verificar si todas las respuestas son correctas
                        final allCorrect = widget.pairs.keys.every((k) => answers[k] == k);
                        if (allCorrect) {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => AlertDialog(
                                title: const Text("¡Felicidades!"),
                                content: const Text("Completaste correctamente la actividad de arrastrar palabras."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Future.delayed(const Duration(milliseconds: 100), () {
                                        widget.onComplete();
                                      });
                                    },
                                    child: const Text("Cerrar"),
                                  )
                                ],
                              ),
                            );
                          });
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
