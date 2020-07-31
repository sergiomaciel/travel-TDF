import 'actividad.dart';
import 'especialidad.dart';
import 'localidad.dart';

class Gastronomico {
  String id;
  String nombre;
  String domicilio;
  String lat;
  String lng;
  String foto = '';
  List<Actividad> actividades;
  List<Especialidad> especialidades;
  Localidad localidad;

  Gastronomico() {
    foto = '';
  }

  Gastronomico.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    nombre = jsonMap['nombre'];
    domicilio = jsonMap['domicilio'];
    lat = jsonMap['lat'].toString();
    lng = jsonMap['lng'].toString();
    foto = jsonMap['foto'].toString();
    actividades = jsonMap['actividad_gastronomicos'] != null ? List.from(jsonMap['actividad_gastronomicos']).map((element) => Actividad.fromJSON(element['actividade'])).toList() : [];
    especialidades = jsonMap['especialidad_gastronomicos'] != null ? List.from(jsonMap['especialidad_gastronomicos']).map((element) => Especialidad.fromJSON(element['especialidade'])).toList() : [];
    localidad = jsonMap['localidade'] != null ? Localidad.fromJSON(jsonMap['localidade']) : Localidad();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'domicilio': domicilio,
      'lat': lat,
      'lng': lng,
      'foto': foto,
      'actividades': actividades,
      'especialidades': especialidades,
      'localidad': localidad,
    };
  }

}
