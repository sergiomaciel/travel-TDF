import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:travel_tdf/src/models/favotito.dart';
import 'package:travel_tdf/src/models/gastronomico.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/usuario.dart';
import '../repository/usuario.dart' as repository;
import '../models/alojamiento.dart';
import '../repository/alojamiento.dart' as repository_alojamiento;
import '../models/gastronomico.dart';
import '../repository/gastronomico.dart' as repo_gastronomico;

class FavoritoController extends ControllerMVC {
  Usuario usuario = repository.currentUser.value;

  Favorito favorito;
  List<Favorito> favoritos = <Favorito>[];

  Alojamiento alojamiento;
  List<Alojamiento> alojamientos = <Alojamiento>[];

  Gastronomico gastronomico;
  List<Gastronomico> gastronomicos = <Gastronomico>[];

  List<DropdownMenuItem> items_filter = [];
  List<int> selectedItems = [];

  GlobalKey<ScaffoldState> scaffoldKey;

  FavoritoController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // list();
    this.favoritos = this.usuario.favoritos;
    loadItems();
    
  }

  void list() {
    listAlojamientos();
    listGastronomicos();
  }

  void listAlojamientos() async {
    final Stream<Alojamiento> stream =
        await repository_alojamiento.getFavoritos();
    stream.listen((Alojamiento _alojamiento) {
      setState(() => alojamientos.add(_alojamiento));
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    }, onDone: () {});
  }

  void listGastronomicos() async {
    repo_gastronomico.getFavoritos().then((List<Gastronomico> list) {
      setState(() => gastronomicos = list);
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    });
  }

  void loadItems() {

    this.usuario.favoritos.forEach((data) => (this.items_filter.add(
                  data.tipo == 'alojamiento'
                  ?  DropdownMenuItem(
                    child: Text(data.alojamiento.nombre),
                    value: data.alojamiento.nombre,
                  )
                  : DropdownMenuItem(
                    child: Text(data.gastronomico.nombre),
                    value: data.gastronomico.nombre,
                  )
                  ))); 

  }

  void update_result() {
    List<Favorito> result = selectedItems.isEmpty
        ? usuario.favoritos
        : usuario.favoritos
            .where((item) => selectedItems.contains(int.parse(item.id) - 1))
            .toList();

    setState(() => this.favoritos = result);
  }
}
