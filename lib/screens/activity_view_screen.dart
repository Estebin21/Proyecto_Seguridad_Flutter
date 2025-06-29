import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import '../models/activity.dart';
import 'drag_activity_widget.dart';
import 'true_false_activity_widget.dart';

class ActivityViewScreen extends StatefulWidget {
  final Activity activity;
  final VoidCallback onComplete;

  const ActivityViewScreen({
    super.key,
    required this.activity,
    required this.onComplete,
  });

  @override
  State<ActivityViewScreen> createState() => _ActivityViewScreenState();
}

class _ActivityViewScreenState extends State<ActivityViewScreen> {
  VideoPlayerController? _videoController;
  String? _localPdfPath;

  @override
  void initState() {
    super.initState();

    if (widget.activity.contentType == "video") {
      _videoController = VideoPlayerController.asset(widget.activity.contentPath)
        ..initialize().then((_) => setState(() {}));
    } else if (widget.activity.contentType == "presentation") {
      _loadPdfFromAssets(widget.activity.contentPath);
    }
  }

  Future<void> _loadPdfFromAssets(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp.pdf');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List(), flush: true);
    setState(() {
      _localPdfPath = tempFile.path;
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;

    return Scaffold(
      appBar: AppBar(title: Text(activity.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(activity.description),
            const SizedBox(height: 20),
            Expanded(
              child: Builder(
                builder: (context) {
                  switch (activity.contentType) {
                    case "image":
                      return Image.asset(activity.contentPath);

                    case "video":
                      if (_videoController?.value.isInitialized ?? false) {
                        return AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: VideoPlayer(_videoController!),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }

                    case "presentation":
                      if (_localPdfPath != null) {
                        return PDFView(
                          filePath: _localPdfPath!,
                          enableSwipe: true,
                          swipeHorizontal: false,
                          autoSpacing: false,
                          pageSnap: true,
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }

                    case "drag":
                      if (activity.title.contains("palabras 1")) {
                        return DragActivityWidget(
                          onComplete: widget.onComplete,
                          pairs: {
                            "Phishing": "Correo falso",
                            "Contraseña": "Clave segura",
                            "Virus": "Malware",
                          },
                        );
                      } else if (activity.title.contains("palabras 2")) {
                        return DragActivityWidget(
                          onComplete: widget.onComplete,
                          pairs: {
                            "Spyware": "Programa espía",
                            "Firewall": "Protección de red",
                            "Antivirus": "Software de seguridad",
                          },
                        );
                      }
                      break;

                    case "truefalse":
                      if (activity.title.contains("Verdadero o Falso 1")) {
                        return TrueFalseActivityWidget(
                          onComplete: widget.onComplete,
                          questions: [
                            Question(text: "Nunca compartas tus contraseñas", answer: true),
                            Question(text: "Es seguro aceptar archivos de extraños", answer: false),
                          ],
                        );
                      } else if (activity.title.contains("Verdadero o Falso 2")) {
                        return TrueFalseActivityWidget(
                          onComplete: widget.onComplete,
                          questions: [
                            Question(text: "Debes actualizar tu antivirus regularmente.", answer: true),
                            Question(text: "Las redes Wi-Fi públicas siempre son seguras.", answer: false),
                          ],
                        );
                      }
                      break;

                    default:
                      return const Text("Tipo de contenido no soportado.");
                  }

                  return const Text("Tipo de contenido no soportado.");
                },
              ),
            ),
            if (activity.contentType != "drag" && activity.contentType != "truefalse")
              ElevatedButton(
                onPressed: widget.onComplete,
                child: const Text("Marcar como completado"),
              ),
          ],
        ),
      ),
      floatingActionButton: activity.contentType == "video" && _videoController != null
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _videoController!.value.isPlaying
                      ? _videoController!.pause()
                      : _videoController!.play();
                });
              },
              child: Icon(
                _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}
