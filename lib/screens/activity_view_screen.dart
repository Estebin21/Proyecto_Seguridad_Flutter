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

    // Inicializa el controlador de video solo si el contenido es un video
    if (widget.activity.contentType == "video") {
      _videoController = VideoPlayerController.asset(widget.activity.contentPath)
        ..initialize().then((_) {
          setState(() {});  // Para actualizar la interfaz cuando el video esté listo
        });
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
                        // Aseguramos que el video no se estire y mantenga la relación de aspecto correcta
                        return AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,  // Relación de aspecto automática
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
                      if (activity.title == "Juega con la dificultad de cada contraseña") {
                      return DragActivityWidget(
                        onComplete: widget.onComplete,
                        pairs: {
                          "Contraseña Alta": "Dino*Rojo73",  // Contraseña segura (Alta)
                          "Contraseña Media": "Gat0Negr0",  // Contraseña intermedia
                          "Contraseña Baja": "gato1",  // Contraseña débil (Baja)
                        },
                      );
                      } else if (activity.title == "Juego interactivo: Navega Seguro") {
                        return DragActivityWidget(
                          onComplete: widget.onComplete,
                          pairs: {
                            "Sitios Confiables": "Busca el candado y que la dirección empiece con 'https://'",
                            "Contraseñas Seguras": "Mezcla letras, números y símbolos en tu contraseña",
                            "No Compartas": "Nunca compartas información personal en línea",
                          },
                        );
                      } else if (activity.title.contains("palabras 1")) {
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
                      } else if (activity.title == "Cómo identificar correos fraudulentos") {
                        return DragActivityWidget(
                          onComplete: widget.onComplete,
                          pairs: {
                            "Dirección del remitente sospechosa": "Parece legítima pero con errores sutiles",
                            "Errores ortográficos y gramaticales": "Indican baja calidad en la redacción; poco común en empresas legítimas",
                            "Solicitudes de información personal urgente": "Intimidan con consecuencias para que compartas datos sensibles",
                            "Archivos adjuntos o enlaces sospechosos":"Pueden contener virus o dirigirte a sitios falsos",
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
                      else if (activity.title == "Detén al Monstruo del Ciberacoso") {
                        return TrueFalseActivityWidget(
                          onComplete: widget.onComplete,
                          questions: [
                            Question(text: "El ciberacoso es cuando una persona se burla de otra en internet.", answer: true),
                            Question(text: "Es seguro compartir tu contraseña con amigos de internet.", answer: false),
                            Question(text: "El bullying en línea solo ocurre en redes sociales.", answer: false),
                          ],
                        );
                      }
                      else if (activity.title == "¡Atrapa al Pescador Falso!") {
                        return TrueFalseActivityWidget(
                          onComplete: widget.onComplete,
                          questions: [
                            Question(text: "Si un mensaje se ve raro, no debes hacer clic en los enlaces.", answer: true),
                            Question(text: "Está bien abrir archivos de personas que no conoces.", answer: false),
                            Question(text: "A veces los correos falsos se ven como si fueran de verdad.", answer: true),
                          ],
                        );
                      }
                      else if (activity.title == "Quiz sobre seguridad en línea") {
                        return TrueFalseActivityWidget(
                          onComplete: widget.onComplete,
                          questions: [
                            Question(text: "Las estafas telefónicas suelen ofrecer problemas urgentes para que tomes decisiones apresuradas.", answer: true),
                            Question(text: "Es seguro compartir tu contraseña con amigos a través de WhatsApp.", answer: false),
                            Question(text: "Una contraseña segura debe tener al menos 12 caracteres combinando letras, números y símbolos.", answer: true),
                            Question(text: "Es seguro hacer clic en enlaces en correos electrónicos de fuentes desconocidas si se ve confiable.", answer: false),
                            Question(text: "Usar Wi-Fi público para acceder a cuentas bancarias es seguro en cualquier casos.", answer: false),
                            Question(text: "Una VPN puede proteger tu información al usar Wi-Fi público, creando una conexión segura.", answer: true),
                            Question(text: "Si recibes un correo sospechoso, siempre es seguro abrir los archivos adjuntos para ver qué contienen.", answer: false),
                            Question(text: "Siempre que la dirección de correo electrónico se vea legítima, puedes confiar en los mensajes de marketing.", answer: false),
                            Question(text: "Si tu cuenta de correo es hackeada, lo primero que debes hacer es cambiar tu contraseña y avisar a tus contactos.", answer: true),
                            Question(text: "Es recomendable usar la misma contraseña para todas tus cuentas en línea para no olvidarlas.", answer: false),
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
