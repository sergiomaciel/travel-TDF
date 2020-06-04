class Especialidad {
  String id;
  String nombre;

  Especialidad();

  Especialidad.fromJSON(Map<String, dynamic> jsonMap) {
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
