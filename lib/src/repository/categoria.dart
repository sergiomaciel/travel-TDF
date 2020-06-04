import 'dart:convert';

import 'package:http/http.dart' as http;
import '../config/api.dart';

import '../Helpers/helper.dart';

import '../models/categoria.dart';

final ApiRest api = ApiRest();

Future<Stream<Categoria>> getCategorias() async {
  final String url = '${api.url()}categorias';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Categoria.fromJSON(data));
}

Future<Stream<Categoria>> getCategoria(String id) async {
  final String url = '${api.url()}categorias?id=eq.$id';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .expand((data) => (data as List))
    .map((data) => Categoria.fromJSON(data));
}
