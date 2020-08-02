import 'dart:io';
import 'alojamiento.dart';
import 'gastronomico.dart';

class Foto {
  String id;
  File local;
  String url;
  String fecha;

  Foto();

  Foto.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    local = jsonMap['local'];
    fecha = jsonMap['fecha'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'local': local,
      'fecha': fecha,
    };
  }

}
