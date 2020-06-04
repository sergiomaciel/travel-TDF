import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/localidad.dart';
import '../repository/localidad.dart' as repository_localidad;
import '../models/alojamiento.dart';
import '../repository/alojamiento.dart' as repository_alojamiento;

class HomeController extends ControllerMVC {
  
  GlobalKey<ScaffoldState> scaffoldKey;

  Localidad localidad;
  List<Localidad> localidades = <Localidad>[];
  Alojamiento alojamiento;
  List<Alojamiento> alojamientos = <Alojamiento>[];

  HomeController() {
    // this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listLocalidad();
    listAlojamiento();
  }

  void viewLocalidad({String id, String msg}) async {
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

  void listLocalidad() async {
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

  void viewAlojamiento({String id, String msg}) async {
    final Stream<Alojamiento> stream = await repository_alojamiento.getAlojamiento(id);
    stream.listen((Alojamiento _alojamiento) {
      setState(() => alojamiento = _alojamiento);
      loadLocalidad(_alojamiento.localidad_id);
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

  void listAlojamiento() async {
    final Stream<Alojamiento> stream = await repository_alojamiento.getAlojamientos();
    stream.listen((Alojamiento _alojamiento) {
      setState(() => alojamientos.add(_alojamiento));
      loadLocalidad(_alojamiento.localidad_id);
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

  void loadLocalidad(String id) async{
    Stream<Localidad> stream = await repository_localidad.getLocalidad(id);
    stream.listen((Localidad _res) {
      setState(() => alojamiento.setLocalidad(_res));
    });
  }

}