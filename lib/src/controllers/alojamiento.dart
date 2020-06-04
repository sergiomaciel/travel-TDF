import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/alojamiento.dart';
import '../repository/alojamiento.dart' as repository_alojamiento;
import '../models/categoria.dart';
import '../repository/categoria.dart' as repository_categoria;
import '../models/clasificacion.dart';
import '../repository/clasificacion.dart' as repository_clasificacion;
import '../models/localidad.dart';
import '../repository/localidad.dart' as repository_localidad;

class AlojamientoController extends ControllerMVC {

  Alojamiento alojamiento;
  List<Alojamiento> alojamientos = <Alojamiento>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  AlojamientoController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void view({String id, String msg}) async {
    final Stream<Alojamiento> stream = await repository_alojamiento.getAlojamiento(id);
    stream.listen((Alojamiento _alojamiento) {
      print('ID DE LA LOCALIDAD ${_alojamiento.localidad_id}');
      
      setState(() => alojamiento = _alojamiento);
      
      loadCategoria(_alojamiento.categoria_id);
      loadClasificacion(_alojamiento.clasificacion_id);
      loadLocalidad(_alojamiento.localidad_id);
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

  void loadLocalidad(String id) async{
    Stream<Localidad> stream = await repository_localidad.getLocalidad(id);
    stream.listen((Localidad _res) {
      setState(() => alojamiento.setLocalidad(_res));
    });
  }

  void loadCategoria(String id) async{
    Stream<Categoria> stream = await repository_categoria.getCategoria(id);
    stream.listen((Categoria _res) {
      setState(() => alojamiento.setCategoria(_res));
    });
  }


  void loadClasificacion(String id) async{
    Stream<Clasificacion> stream = await repository_clasificacion.getClasificacion(id);
    stream.listen((Clasificacion _res) {
      setState(() => alojamiento.setClasificacion(_res));
    });
  }

  void list() async {
    final Stream<Alojamiento> stream = await repository_alojamiento.getAlojamientos();
    stream.listen((Alojamiento _alojamiento) {
      setState(() => alojamientos.add(_alojamiento));
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

  Future<void> refresh() async {
    var _id = alojamiento.id;
    alojamiento = new Alojamiento();
    view(id: _id);
  }

}