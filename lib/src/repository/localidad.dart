import 'dart:convert';

import 'package:http/http.dart' as http;
import '../config/api.dart';

import '../Helpers/helper.dart';

import '../models/localidad.dart';

final ApiRest api = ApiRest();

Future<Stream<Localidad>> getLocalidades() async {
  final String url = '${api.url()}localidades';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Localidad.fromJSON(data));
}

Future<Stream<Localidad>> getLocalidad(String id) async {
  final String url = '${api.url()}localidades?id=eq.$id';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .expand((data) => (data as List))
    .map((data) => Localidad.fromJSON(data));
}
