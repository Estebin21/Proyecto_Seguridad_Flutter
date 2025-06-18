import '../models/activity.dart';

List<List<Activity>> activityGroups = [
  // Grupo 1: Menores de 10 años
  [
    Activity(
      title: "No compartas contraseñas en línea nunca",
      description: "Nunca debes compartir tu contraseña con extraños.",
      contentType: "image",
      contentPath: "assets/images/actividad_1.png",
      order: 1,
    ),
    Activity(
      title: "Aprende con este video animado",
      description: "Video educativo sobre seguridad básica.",
      contentType: "video",
      contentPath: "assets/videos/actividad_2.mp4",
      order: 2,
    ),
    Activity(
      title: "Presentación sobre navegación segura",
      description: "Infografía en PDF con consejos visuales.",
      contentType: "presentation",
      contentPath: "assets/presentations/actividad_3.pdf",
      order: 3,
    ),
    // Agrega más hasta completar 10
  ],

  // Grupo 2: Entre 10 y 50 años
  [
    Activity(
      title: "Protección de tu identidad en redes",
      description: "Infografía explicativa.",
      contentType: "image",
      contentPath: "assets/images/actividad_11.jpg",
      order: 1,
    ),
    Activity(
      title: "Video sobre phishing",
      description: "Aprende a detectar correos sospechosos.",
      contentType: "video",
      contentPath: "assets/videos/phishing_adultos.mp4",
      order: 2,
    ),
    Activity(
      title: "Presentación de buenas prácticas",
      description: "PDF con normas de uso seguro de redes sociales.",
      contentType: "presentation",
      contentPath: "assets/presentations/buenas_practicas.pdf",
      order: 3,
    ),
    // Agrega más hasta completar 10
  ],

  // Grupo 3: Mayores de 50 años
  [
    Activity(
      title: "Cuidado con las estafas telefónicas",
      description: "Imagen ilustrativa para identificar fraudes.",
      contentType: "image",
      contentPath: "assets/images/actividad_21.jpg",
      order: 1,
    ),
    Activity(
      title: "Video guía sobre WhatsApp seguro",
      description: "Cómo protegerse en apps de mensajería.",
      contentType: "video",
      contentPath: "assets/videos/whatsapp_seguro.mp4",
      order: 2,
    ),
    Activity(
      title: "Presentación sobre contraseñas fuertes",
      description: "PDF educativo sobre buenas prácticas.",
      contentType: "presentation",
      contentPath: "assets/presentations/contraseñas_fuertes.pdf",
      order: 3,
    ),
    // Agrega más hasta completar 10
  ],
];
