class Localidad {
  String id;
  String nombre;

  Localidad() {
    this.nombre = 'Localidad';
  }

  Localidad.fromJSON(Map<String, dynamic> jsonMap) {
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
