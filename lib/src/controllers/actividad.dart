import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/actividad.dart';
import '../repository/actividad.dart' as repository_actividad;

class ActividadController extends ControllerMVC {

  Actividad actividad;
  List<Actividad> actividades = <Actividad>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  ActividadController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void view({String id, String msg}) async {
    final Stream<Actividad> stream = await repository_actividad.getActividad(id);
    stream.listen((Actividad _actividad) {
      setState(() => actividad = _actividad);
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
    final Stream<Actividad> stream = await repository_actividad.getActividades();
    stream.listen((Actividad _actividad) {
      setState(() => actividades.add(_actividad));
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