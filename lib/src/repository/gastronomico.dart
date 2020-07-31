import 'dart:convert';
import 'package:graphql/client.dart';
import 'package:location/location.dart';

import '../config/api.dart';
import '../Helpers/helper.dart';
import '../models/gastronomico.dart';

import 'package:hasura_connect/hasura_connect.dart';

final GraphQl api = GraphQl();
String url = api.url();
HasuraConnect hasuraConnect = HasuraConnect(url);

Future<List<Gastronomico>> getGastronomicos() async {
  final result = await hasuraConnect.query(api.listGastronomicos);
  final data = result['data']['gastronomicos'] as List;
  final List<Gastronomico> list = data.map((e) => Gastronomico.fromJSON(e)).toList();
  return list;
}

Future<Gastronomico> getGastronomico(String id) async {
  final result = await hasuraConnect.query(api.getGastronomico(int.parse(id)));
  final Gastronomico data =  Gastronomico.fromJSON(result['data']['gastronomicos_by_pk']);
  return data;
}

// Future<Stream<Alojamiento>> getAlojamiento(String id) async {
//   final String url = '${api.url()}alojamientos?id=eq.$id';

//   final client = new http.Client();
//   final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

//   return streamedRest.stream
//     .transform(utf8.decoder)
//     .transform(json.decoder)
//     .expand((data) => (data as List))
//     .map((data) => Alojamiento.fromJSON(data));
// }

// Future<Stream<Alojamiento>> getNearRestaurants(LocationData myLocation, LocationData areaLocation) async {
//   String _nearParams = '';
//   String _orderLimitParam = '';
//   if (myLocation != null && areaLocation != null) {
//     _orderLimitParam = 'orderBy=area&limit=5';
//     _nearParams = '&myLon=${myLocation.longitude}&myLat=${myLocation.latitude}&areaLon=${areaLocation.longitude}&areaLat=${areaLocation.latitude}';
//   }
//   final String url = '${api.url()}alojamientos??$_nearParams&$_orderLimitParam';

//   final client = new http.Client();
//   final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

//   return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
//     return Alojamiento.fromJSON(data);
//   });
// }
