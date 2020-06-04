import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/clasificacion.dart';
import '../repository/clasificacion.dart' as repository_clasificacion;

class ClasificacionController extends ControllerMVC {

  Clasificacion clasificacion;
  List<Clasificacion> clasificaciones = <Clasificacion>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  ClasificacionController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void view({String id, String msg}) async {
    final Stream<Clasificacion> stream = await repository_clasificacion.getClasificacion(id);
    stream.listen((Clasificacion clasificacion) {
      setState(() => clasificacion = clasificacion);
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
    final Stream<Clasificacion> stream = await repository_clasificacion.getClasificaciones();
    stream.listen((Clasificacion clasificacion) {
      setState(() => clasificaciones.add(clasificacion));
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