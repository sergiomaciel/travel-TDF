import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import '../config/api.dart';

import '../Helpers/helper.dart';

import '../models/alojamiento.dart';

final ApiRest api = ApiRest();

Future<Stream<Alojamiento>> getAlojamientos() async {
  final String url = '${api.url()}alojamientos?select=*,categorias(*),localidades(*),clasificaciones(*)';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .expand((data) => (data as List))
    .map((data) => Alojamiento.fromJSON(data));
}

Future<Stream<Alojamiento>> getAlojamiento(String id) async {
  final String url = '${api.url()}alojamientos?eq.$id&select=*,categorias(*),localidades(*),clasificaciones(*)';
  

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .expand((data) => (data as List))
    .map((data) => Alojamiento.fromJSON(data));
}

Future<Stream<Alojamiento>> getNearRestaurants(LocationData myLocation, LocationData areaLocation) async {
  String _nearParams = '';
  String _orderLimitParam = '';
  if (myLocation != null && areaLocation != null) {
    _orderLimitParam = 'orderBy=area&limit=5';
    _nearParams = '&myLon=${myLocation.longitude}&myLat=${myLocation.latitude}&areaLon=${areaLocation.longitude}&areaLat=${areaLocation.latitude}';
  }
  final String url = '${api.url()}alojamientos??$_nearParams&$_orderLimitParam';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
    return Alojamiento.fromJSON(data);
  });
}
