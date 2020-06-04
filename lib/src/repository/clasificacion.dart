import 'dart:convert';

import 'package:http/http.dart' as http;
import '../config/api.dart';

import '../Helpers/helper.dart';

import '../models/clasificacion.dart';

final ApiRest api = ApiRest();

Future<Stream<Clasificacion>> getClasificaciones() async {
  final String url = '${api.url()}clasificaciones';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Clasificacion.fromJSON(data));
}

Future<Stream<Clasificacion>> getClasificacion(String id) async {
  final String url = '${api.url()}clasificaciones?id=eq.$id';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .expand((data) => (data as List))
    .map((data) => Clasificacion.fromJSON(data)); 
}
