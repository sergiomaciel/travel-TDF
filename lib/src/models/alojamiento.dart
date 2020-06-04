import '../models/categoria.dart';
import '../controllers/categoria.dart';
import '../models/clasificacion.dart';
import '../controllers/clasificacion.dart';
import '../models/localidad.dart';
import '../controllers/localidad.dart';
import '../repository/localidad.dart' as repo_localidad;

class Alojamiento {
  String id;
  String nombre;
  String domicilio;
  String lat;
  String lng;
  String foto;
  String categoria_id;
  String clasificacion_id;
  String localidad_id;
  Categoria _categoria;
  Clasificacion _clasificacion;
  Localidad _localidad;

  Alojamiento();

  Alojamiento.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    nombre = jsonMap['nombre'];
    domicilio = jsonMap['domicilio'];
    lat = jsonMap['lat'].toString();
    lng = jsonMap['lng'].toString();
    foto = jsonMap['foto'].toString();
    categoria_id = jsonMap['categoria_id'].toString();
    clasificacion_id = jsonMap['clasificacion_id'].toString();
    localidad_id = jsonMap['localidad_id'].toString();
    _localidad = jsonMap['localidad'] != null ? Localidad.fromJSON(jsonMap['localidad']) : Localidad();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'domicilio': domicilio,
      'lat': lat,
      'lng': lng,
      'foto': foto,
      'categoria_id': categoria_id,
      'clasificacion_id': clasificacion_id,
      'localidad_id': localidad_id,
    };
  }

  void setCategoria(Categoria categoria) {
    this._categoria = categoria;
  }

  Categoria getCategoria() {
    return this._categoria;
  }

  void setClasificacion(Clasificacion clasificacion) {
    this._clasificacion = clasificacion;
  }

  Clasificacion getClasificacion() {
    return this._clasificacion;
  }

    void setLocalidad(Localidad localidad) {
    this._localidad = localidad;
  }

  Localidad getLocalidad() {
    return this._localidad;
  }
}
