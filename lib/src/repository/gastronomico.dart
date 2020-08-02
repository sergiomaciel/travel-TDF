import 'dart:convert';
import 'dart:async';
import 'package:graphql/client.dart';
import 'package:location/location.dart';
import '../models/favotito.dart';

import '../models/usuario.dart';
import '../repository/usuario.dart' as userRepo;

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
  final List<Gastronomico> list =
      data.map((e) => Gastronomico.fromJSON(e)).toList();
  return list;
}

Future<Gastronomico> getGastronomico(String id) async {
  final result = await hasuraConnect.query(api.getGastronomico(int.parse(id)));
  final Gastronomico data =
      Gastronomico.fromJSON(result['data']['gastronomicos_by_pk']);
  return data;
}

Future<List<Gastronomico>> getFavoritos() async {
  Usuario _user = userRepo.currentUser.value;
  final List<String> ids = _user.favoritos
      .where((item) => (item.tipo == 'gastronomico'))
      .map((item) => item.id_establecimiento)
      .toList();
  final result = await hasuraConnect.query(api.getFavoritos(ids.join(',')));
  final data = result['data']['gastronomicos'] as List;
  final List<Gastronomico> list =
      data.map((e) => Gastronomico.fromJSON(e)).toList();
  return list;
}

Future<Favorito> isFavorito(String id) async {
  Usuario _user = userRepo.currentUser.value;
  Favorito _favorito = Favorito();

  // _user.favoritos.forEach((data){
  //   if ((data.tipo == 'gastronomico') && (data.alojamiento.id == id )) {
  //     _favorito = data;
  //   } 
  // });

  _favorito = _user.favoritos
      .where((item) => (item.tipo == 'gastronomico'))
      .firstWhere((item) => item.gastronomico.id == id);

  return _favorito;
}

Future<Favorito> addFavorito(Gastronomico gastronomico) async {
  Usuario _user = userRepo.currentUser.value;
  Favorito _favorito = Favorito();

  _favorito.id = (_user.favoritos.length + 1).toString();
  _favorito.gastronomico = gastronomico;
  _favorito.tipo = 'gastronomico';

  _user.favoritos.add(_favorito);
  userRepo.currentUser.value = _user;
  return _favorito;
}

Future<Favorito> removeFavorito(String id) async {
  Usuario _user = userRepo.currentUser.value;
  Favorito _favorito = Favorito();

  _favorito = _user.favoritos
      .where((item) => (item.tipo == 'gastronomico'))
      .firstWhere((item) => (item.gastronomico.id == id));

  userRepo.currentUser.value.favoritos.remove(_favorito);
  return _favorito;
}
