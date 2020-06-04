import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/especialidad.dart';
import '../repository/especialidad.dart' as repository_especialidad;

class EspecialidadController extends ControllerMVC {

  Especialidad especialidad;
  List<Especialidad> especialidades = <Especialidad>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  EspecialidadController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void view({String id, String msg}) async {
    final Stream<Especialidad> stream = await repository_especialidad.getEspecialidad(id);
    stream.listen((Especialidad _especialidad) {
      setState(() => especialidad = _especialidad);
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
    final Stream<Especialidad> stream = await repository_especialidad.getEspecialidades();
    stream.listen((Especialidad _especialidad) {
      setState(() => especialidades.add(_especialidad));
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