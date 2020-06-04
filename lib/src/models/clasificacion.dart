class Clasificacion {
  String id;
  String nombre;

  Clasificacion();

  Clasificacion.fromJSON(Map<String, dynamic> jsonMap) {
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
