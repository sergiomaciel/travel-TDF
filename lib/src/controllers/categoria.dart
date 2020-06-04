import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/categoria.dart';
import '../repository/categoria.dart' as repository_categoria;

class CategoriaController extends ControllerMVC {

  Categoria categoria;
  List<Categoria> categorias = <Categoria>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  CategoriaController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void view({String id, String msg}) async {
    final Stream<Categoria> stream = await repository_categoria.getCategoria(id);
    stream.listen((Categoria _categoria) {
      setState(() => categoria = _categoria);
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    }, onDone: () {
      if (msg != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(msg),
        ));
      }
    });
  }

  void list() async {
    final Stream<Categoria> stream = await repository_categoria.getCategorias();
    stream.listen((Categoria _categoria) {
      setState(() => categorias.add(_categoria));
    },
    onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    },
    onDone: () {
      
    });
  }

}