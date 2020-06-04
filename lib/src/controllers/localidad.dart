import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/localidad.dart';
import '../repository/localidad.dart' as repository_localidad;

class LocalidadController extends ControllerMVC {

  Localidad localidad;
  List<Localidad> localidades = <Localidad>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  LocalidadController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void view({String id, String msg}) async {
    final Stream<Localidad> stream = await repository_localidad.getLocalidad(id);
    stream.listen((Localidad _localidad) {
      setState(() => localidad = _localidad);
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
    final Stream<Localidad> stream = await repository_localidad.getLocalidades();
    stream.listen((Localidad _localidad) {
      setState(() => localidades.add(_localidad));
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