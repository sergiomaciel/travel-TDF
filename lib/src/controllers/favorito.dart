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
  Usuario user = repository.currentUser.value;

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
    listAlojamientos();
    // listGastronomicos();
    loadItems();
  }

  void view({String id, String tipo, String msg}) async {
    if (tipo == 'gastronomico') {
      viewGastronomicos(id: id, msg: msg);
    } else {
      viewAlojamiento(id: id, msg: msg);
    }
  }

  void viewAlojamiento({String id, String msg}) async {
    final Stream<Alojamiento> stream =
        await repository_alojamiento.getAlojamiento(id);
    stream.listen((Alojamiento _alojamiento) {
      setState(() => alojamiento = _alojamiento);
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    }, onDone: () {
      if (msg != null) {
        // scaffoldKey.currentState.showSnackBar(SnackBar(
        //   content: Text(msg),
        // ));
      }
    });
  }

  void listAlojamientos() async {
    final Stream<Alojamiento> stream = await repository_alojamiento.getFavoritos();
    stream.listen((Alojamiento _alojamiento) {
      setState(() => alojamientos.add(_alojamiento));
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    }, onDone: () {});
  }

  void viewGastronomicos({String id, String msg}) async {
    repo_gastronomico.getGastronomico(id).then((Gastronomico data) {
      setState(() => gastronomico = data);
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    });
  }

  void listGastronomicos() async {
    user.favoritos
        .where((item) => (item.tipo == 'gastronomico'))
        .map((item) => (Favorito item) {
              repo_gastronomico.getGastronomico(item.id_establecimiento).then(
                  (Gastronomico data) {
                setState(() => gastronomicos.add(data));
              }, onError: (a) {
                print(a);
                scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Error Internet'),
                ));
              });
            })
        .toList();
  }

  void loadItems() async {
    // final Stream<Categoria> stream = await repository_categoria.getCategorias();
    // stream.listen((Categoria _categoria) {
    //   setState(() => items_filter.add(DropdownMenuItem(
    //         child: Text(_categoria.estrellas),
    //         value: _categoria.estrellas,
    //       )));
    // }, onError: (a) {
    //   print(a);
    //   scaffoldKey.currentState.showSnackBar(SnackBar(
    //     content: Text('Error Internet'),
    //   ));
    // }, onDone: () {});
  }

  Future<void> refresh() async {
    var _id = alojamiento.id;
    alojamiento = new Alojamiento();
    view(id: _id);
  }
}
