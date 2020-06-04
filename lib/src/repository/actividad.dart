import 'dart:convert';

import 'package:http/http.dart' as http;
import '../config/api.dart';

import '../Helpers/helper.dart';

import '../models/actividad.dart';

final ApiRest api = ApiRest();

Future<Stream<Actividad>> getActividades() async {
  final String url = '${api.url()}actividades';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Actividad.fromJSON(data));
}

Future<Stream<Actividad>> getActividad(String id) async {
  final String url = '${api.url()}actividades?id=eq.$id';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .expand((data) => (data as List))
    .map((data) => Actividad.fromJSON(data));
}
