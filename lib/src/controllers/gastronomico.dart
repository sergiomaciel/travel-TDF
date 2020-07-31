import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/gastronomico.dart';
import '../repository/gastronomico.dart' as repo_gastronomico;

import '../models/localidad.dart';
import '../repository/localidad.dart' as repo_localidad;

class GastronomicoController extends ControllerMVC {
  Gastronomico gastronomico;
  List<Gastronomico> gastronomicos = <Gastronomico>[];
  List<Gastronomico> result_gastronomico = <Gastronomico>[];

  List<DropdownMenuItem> items_filter_actividad = [];
  List<int> selectedItemsActividad = [];
  List<DropdownMenuItem> items_filter_especialidad = [];
  List<int> selectedItemsEspecialidad = [];
  List<DropdownMenuItem> items_filter_localidad = [];
  List<int> selectedItemsLocalidad = [];
  
  GlobalKey<ScaffoldState> scaffoldKey;

  GastronomicoController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    list();
    loadItemsLocalidad();
  }

  void view({String id, String msg}) async {
    repo_gastronomico.getGastronomico(id).then(( Gastronomico data) {
      setState(() => gastronomico = data);
    },
    onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    });
  }

  void loadItemsLocalidad() async {
    final Stream<Localidad> stream = await repo_localidad.getLocalidades();
    stream.listen((Localidad _localidad) {
      setState(() => items_filter_localidad.add(DropdownMenuItem(
            child: Text(_localidad.nombre),
            value: _localidad.nombre,
          )));
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    }, onDone: () {});
  }


  void update_result() {
    List<Gastronomico> data = gastronomicos.where((item) => selectedItemsLocalidad.isEmpty
            ? true
            : selectedItemsLocalidad.contains(int.parse(item.localidad.id) - 1))
        .toList();
    setState(() => result_gastronomico = data);
  }

  void list() async {
      repo_gastronomico.getGastronomicos().then(( List<Gastronomico> data) {
      setState(() => gastronomicos = data);
      setState(() => result_gastronomico = data);
    },
    onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    });
  }

  Future<void> refresh() async {
    var _id = gastronomico.id;
    gastronomico = new Gastronomico();
    view(id: _id);
  }
}
