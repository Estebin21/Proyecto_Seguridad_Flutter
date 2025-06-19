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
      title: "10 consejos",
      description: "Guiate mediante este video sobre 10 consejos de internet",
      contentType: "video",
      contentPath: "assets/videos/actividad_12.mp4",
      order: 2,
    ),
    Activity(
      title: "Guía de seguridad",
      description: "PDF con seguridad recomendada de la UNICEF",
      contentType: "presentation",
      contentPath: "assets/presentations/actividad_13.pdf",
      order: 3,
    ),
    Activity(
      title: "Arrastra las palabras 1",
      description: "Ubica correctamente cada palabra clave",
      contentType: "drag",
      contentPath: "",
      order: 4,
    ),
    Activity(
      title: "Actividad de Verdadero o Falso 1",
      description: "Responde si las afirmaciones son verdaderas o falsas.",
      contentType: "truefalse",
      contentPath: "",
      order: 5,
    ),
    Activity(
      title: "El ciberacoso",
      description: "Infografía acerca del ciberacoso",
      contentType: "image",
      contentPath: "assets/images/actividad_16.jpg",
      order: 6,
    ),
    Activity(
      title: "5 consejos",
      description: "Guíate mediante este video sobre 5 del ciberacoso",
      contentType: "video",
      contentPath: "assets/videos/actividad_17.mp4",
      order: 7,
    ),
    Activity(
      title: "Explicación sobre ciberacoso",
      description: "PDF con información acerca del ciberacoso",
      contentType: "presentation",
      contentPath: "assets/presentations/actividad_18.pdf",
      order: 8,
    ),
    Activity(
      title: "Arrastra las palabras 2",
      description: "Ubica correctamente cada palabra clave",
      contentType: "drag",
      contentPath: "",
      order: 9,
    ),
    Activity(
      title: "Actividad de Verdadero o Falso 2",
      description: "Responde si las afirmaciones son verdaderas o falsas.",
      contentType: "truefalse",
      contentPath: "",
      order: 10,
    ),
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
