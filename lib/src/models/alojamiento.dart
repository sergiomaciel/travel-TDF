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
  // String categoria_id;
  Categoria categoria;
  // String clasificacion_id;
  // String localidad_id;
  // Categoria _categoria;
  // Clasificacion _clasificacion;
  Clasificacion clasificacion;
  // Localidad _localidad;
  Localidad localidad;
  
  Alojamiento();


  Alojamiento.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    nombre = jsonMap['nombre'];
    domicilio = jsonMap['domicilio'];
    lat = jsonMap['lat'].toString();
    lng = jsonMap['lng'].toString();
    foto = jsonMap['foto'].toString();
    
    // categoria_id = jsonMap['categoria_id'].toString();
    categoria = jsonMap['categorias'] != null ? Categoria.fromJSON(jsonMap['categorias']) : Categoria();
    
    // clasificacion_id = jsonMap['clasificacion_id'].toString();
    clasificacion = jsonMap['clasificaciones'] != null ? Clasificacion.fromJSON(jsonMap['clasificaciones']) : Clasificacion();
    
    // localidad_id = jsonMap['localidad_id'].toString();
    localidad = jsonMap['localidades'] != null ? Localidad.fromJSON(jsonMap['localidades']) : Localidad();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'domicilio': domicilio,
      'lat': lat,
      'lng': lng,
      'foto': foto,
      'categoria': categoria,
      'clasificacion': clasificacion,
      'localidad': localidad,
    };
  }

  // void setCategoria(Categoria categoria) {
  //   this._categoria = categoria;
  // }

  // Categoria getCategoria() {
  //   return this._categoria;
  // }

  // void setClasificacion(Clasificacion clasificacion) {
  //   this._clasificacion = clasificacion;
  // }

  // Clasificacion getClasificacion() {
  //   return this._clasificacion;
  // }

  //   void setLocalidad(Localidad localidad) {
  //   this._localidad = localidad;
  // }

  // Localidad getLocalidad() {
  //   return this._localidad;
  // }
}
