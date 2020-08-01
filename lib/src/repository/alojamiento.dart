import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import '../models/favotito.dart';
import '../models/usuario.dart';
import '../repository/usuario.dart' as userRepo;
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
  final String url = '${api.url()}alojamientos?id=eq.$id&select=*,categorias(*),localidades(*),clasificaciones(*)';
  

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .expand((data) => (data as List))
    .map((data) => Alojamiento.fromJSON(data));
}

Future<Stream<Alojamiento>> getFavoritos() async {
  Usuario _user = userRepo.currentUser.value;
  final List<String> ids = _user.favoritos.where((item) => (item.tipo == 'alojamiento')).map((item) => item.id_establecimiento).toList();
  final String url = '${api.url()}alojamientos?id=in.(${ids.join(',')})&select=*,categorias(*),localidades(*),clasificaciones(*)';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .expand((data) => (data as List))
    .map((data) => Alojamiento.fromJSON(data));
}

Future<bool> isFavorito(String id) async {
  Usuario _user = userRepo.currentUser.value;
    
  final List<String> ids = _user.favoritos.where((item) => (item.tipo == 'alojamiento')).map((item) => item.id_establecimiento).toList();
  
  return ids.contains(id);
}

Future<Favorito> addFavorito(String id) async {
  Usuario _user = userRepo.currentUser.value;
  Favorito _favorito = Favorito();

  _favorito.id = (_user.favoritos.length + 1).toString();
  _favorito.id_establecimiento = id;
  _favorito.tipo = 'alojamiento';

  _user.favoritos.add(_favorito);
  userRepo.currentUser.value = _user;
  return _favorito;
}

Future<Favorito> removeFavorito(String id) async {
  Usuario _user = userRepo.currentUser.value;
  Favorito _favorito = Favorito();

  _favorito = _user.favoritos
  .where((item) => (item.tipo == 'alojamiento'))
  .firstWhere((item) => (item.id_establecimiento == id));

  userRepo.currentUser.value.favoritos.remove(_favorito);
  return _favorito;
}
