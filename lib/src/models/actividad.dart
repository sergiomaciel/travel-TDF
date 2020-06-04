class Actividad {
  String id;
  String nombre;

  Actividad();

  Actividad.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    nombre = jsonMap['nombre'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre
    };
  }
}
