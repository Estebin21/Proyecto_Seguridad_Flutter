import 'package:flutter/material.dart';

class TrueFalseActivityWidget extends StatefulWidget {
  final VoidCallback onComplete;

  const TrueFalseActivityWidget({super.key, required this.onComplete});

  @override
  State<TrueFalseActivityWidget> createState() => _TrueFalseActivityWidgetState();
}

class _TrueFalseActivityWidgetState extends State<TrueFalseActivityWidget> {
  final List<_Question> _questions = [
    _Question(text: "Nunca debes compartir tus contraseñas.", answer: true),
    _Question(text: "Es seguro aceptar archivos de desconocidos.", answer: false),
    _Question(text: "Usar redes públicas para ingresar al banco es recomendable.", answer: false),
  ];

  int _current = 0;
  bool _answered = false;
  bool _isCorrect = false;

  void _answer(bool value) {
    setState(() {
      _answered = true;
      _isCorrect = value == _questions[_current].answer;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_current < _questions.length - 1) {
        setState(() {
          _current++;
          _answered = false;
        });
      } else {
        // Mostrar diálogo de felicitación SOLO cuando finaliza
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text("¡Felicidades!"),
            content: const Text("Has completado todas las preguntas de verdadero o falso."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el diálogo
                  widget.onComplete();         // Marca la actividad como completada
                },
                child: const Text("Cerrar"),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_current];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question.text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        if (!_answered)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _answer(true),
                child: const Text("Verdadero"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => _answer(false),
                child: const Text("Falso"),
              ),
            ],
          )
        else
          Icon(
            _isCorrect ? Icons.check_circle : Icons.cancel,
            color: _isCorrect ? Colors.green : Colors.red,
            size: 60,
          ),
      ],
    );
  }
}

class _Question {
  final String text;
  final bool answer;

  _Question({required this.text, required this.answer});
}
