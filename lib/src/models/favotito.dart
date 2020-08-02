import 'dart:io';

import '../models/foto.dart';
import '../models/alojamiento.dart';
import '../models/gastronomico.dart';

class Favorito {
  String id;
  List<Foto> fotos = <Foto>[];
  Alojamiento alojamiento;
  Gastronomico gastronomico;
  String id_establecimiento;
  String tipo;

  Favorito();

  Favorito.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] != null ? jsonMap['id'].toString() : null;
    tipo = jsonMap['tipo'] != null ? jsonMap['tipo'].toString() : null;
    id_establecimiento = jsonMap['id_establecimiento'];
    fotos = jsonMap['fotos'] != null ? List.from(jsonMap['fotos']).map((element) => Foto.fromJSON(element)).toList() : [];
    alojamiento = jsonMap['alojamiento'] != null ? Alojamiento.fromJSON(jsonMap['alojamiento']) : null;
    gastronomico = jsonMap['gastronomico'] != null ? Gastronomico.fromJSON(jsonMap['gastronomico']) : null;
    // fotos = List.from(jsonMap['fotos']).map((element) => File(element) ).toList();
    // fotos = List.from(jsonMap['fotos']).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fotos': fotos,
      'tipo': tipo,
      'id_establecimiento': id_establecimiento
    };
  }

}
