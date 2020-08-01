import 'dart:io';
import 'alojamiento.dart';
import 'gastronomico.dart';

class Foto {
  String id;
  File foto;

  Foto();

  Foto.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    foto = jsonMap['foto'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'foto': foto
    };
  }

}
