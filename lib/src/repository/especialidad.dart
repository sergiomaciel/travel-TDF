import 'dart:convert';

import 'package:http/http.dart' as http;
import '../config/api.dart';

import '../Helpers/helper.dart';

import '../models/especialidad.dart';

final ApiRest api = ApiRest();

Future<Stream<Especialidad>> getEspecialidades() async {
  final String url = '${api.url()}especialidades';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Especialidad.fromJSON(data));
}

Future<Stream<Especialidad>> getEspecialidad(String id) async {
  final String url = '${api.url()}especialidades?id=eq.$id';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .expand((data) => (data as List))
    .map((data) => Especialidad.fromJSON(data));
}
