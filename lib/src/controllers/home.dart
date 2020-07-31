import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/localidad.dart';
import '../repository/localidad.dart' as repo_localidad;
import '../models/alojamiento.dart';
import '../repository/alojamiento.dart' as repo_alojamiento;
import '../models/gastronomico.dart';
import '../repository/gastronomico.dart' as repo_gastronomico;

class HomeController extends ControllerMVC {
  
  GlobalKey<ScaffoldState> scaffoldKey;

  Alojamiento alojamiento;
  List<Alojamiento> alojamientos = <Alojamiento>[];
  Gastronomico gastronomico;
  List<Gastronomico> gastronomicos = <Gastronomico>[];
  Localidad localidad;
  List<Localidad> localidades = <Localidad>[];

  HomeController() {
    // this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listLocalidad();
    listAlojamiento();
    listGastronomico();
  }

  void viewLocalidad({String id, String msg}) async {
    final Stream<Localidad> stream = await repo_localidad.getLocalidad(id);
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
    final Stream<Localidad> stream = await repo_localidad.getLocalidades();
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
    final Stream<Alojamiento> stream = await repo_alojamiento.getAlojamiento(id);
    stream.listen((Alojamiento _alojamiento) {
      setState(() => alojamiento = _alojamiento);
      // loadLocalidad(_alojamiento.localidad_id);
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
    final Stream<Alojamiento> stream = await repo_alojamiento.getAlojamientos();
    stream.listen((Alojamiento _alojamiento) {
      setState(() => alojamientos.add(_alojamiento));
      // loadLocalidad(_alojamiento.localidad_id);
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

  void listGastronomico() async {

    repo_gastronomico.getGastronomicos().then(( List<Gastronomico> data) {
      setState(() => gastronomicos = data);
      // loadLocalidad(_gastronomico.localidad_id);
    },
    onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    });
  }

  // // void loadLocalidad(String id) async{
  //   Stream<Localidad> stream = await repo_localidad.getLocalidad(id);
  //   stream.listen((Localidad _res) {
  //     setState(() => alojamiento.setLocalidad(_res));
  //   });
  // }

}