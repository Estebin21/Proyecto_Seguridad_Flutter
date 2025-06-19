import 'package:flutter/material.dart';

class TrueFalseActivityWidget extends StatefulWidget {
  final VoidCallback onComplete;
  final List<Question> questions;

  const TrueFalseActivityWidget({
    super.key,
    required this.onComplete,
    required this.questions,
  });

  @override
  State<TrueFalseActivityWidget> createState() => _TrueFalseActivityWidgetState();
}

class _TrueFalseActivityWidgetState extends State<TrueFalseActivityWidget> {
  int _current = 0;
  bool _answered = false;
  bool _isCorrect = false;

  void _answer(bool value) {
    setState(() {
      _answered = true;
      _isCorrect = value == widget.questions[_current].answer;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      if (_current < widget.questions.length - 1) {
        setState(() {
          _current++;
          _answered = false;
        });
      } else {
        widget.onComplete();
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("¡Felicidades!"),
            content: const Text("Has completado todas las preguntas de verdadero o falso."),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
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
    final question = widget.questions[_current];

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

class Question {
  final String text;
  final bool answer;

  Question({required this.text, required this.answer});
}
