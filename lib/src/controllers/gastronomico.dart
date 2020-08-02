import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:travel_tdf/src/models/favotito.dart';
import 'package:travel_tdf/src/models/foto.dart';

import '../models/gastronomico.dart';
import '../repository/gastronomico.dart' as repo_gastronomico;

import '../models/localidad.dart';
import '../repository/localidad.dart' as repo_localidad;

class GastronomicoController extends ControllerMVC {
  Gastronomico gastronomico;
  List<Gastronomico> gastronomicos = <Gastronomico>[];
  List<Gastronomico> result_gastronomico = <Gastronomico>[];

  Favorito favorito = Favorito();
  bool esFavorito = false;
  File _image;
  bool filtros = false;

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
    repo_gastronomico.getGastronomico(id).then((Gastronomico data) {
      setState(() => gastronomico = data);
      isFavorito(data.id);
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    });
  }

  void list() async {
    repo_gastronomico.getGastronomicos().then((List<Gastronomico> data) {
      setState(() => gastronomicos = data);
      setState(() => result_gastronomico = data);
    }, onError: (a) {
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
    List<Gastronomico> result = selectedItemsLocalidad.isEmpty
        ? this.gastronomicos
        : gastronomicos
            .where((item) =>
                selectedItemsLocalidad.contains(int.parse(item.id) - 1))
            .toList();
    setState(() => this.result_gastronomico = result);
  }

  void isFavorito(String id) async {
    repo_gastronomico.isFavorito(id).then((Favorito _favorito) {
      setState(() {
        if (_favorito != null) {
          this.favorito = _favorito;
          this.esFavorito = true;
        } else {
          this.esFavorito = true;
        }
      });
    });
  }

  void agregarFavorito(String id) async {
    repo_gastronomico.addFavorito(this.gastronomico).then((Favorito value) {
      setState(() {
        this.favorito = value;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Alojamiento agregado a favoritos'),
      ));
      isFavorito(gastronomico.id);
    });
  }

  void eliminarFavorite(String id) async {
    repo_gastronomico.removeFavorito(id).then((value) {
      setState(() {
        this.favorito = new Favorito();
        this.esFavorito = false;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Alojamiento eliminado de favoritos'),
      ));
      isFavorito(gastronomico.id);
    });
  }

  void _addImg(File image) {
    setState(() {
      _image = image;

      Foto _foto = Foto();
      _foto.id = (this.favorito.fotos.length + 1).toString();
      _foto.fecha = image.lastModifiedSync().toString().substring(0, 16);
      _foto.local = image;

      this.favorito.fotos.add(_foto);
    });
  }

  void _open_camera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    this._addImg(image);
  }

  void _open_gallery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this._addImg(image);
  }

  Future agregarFoto() async {
    showDialog(
        context: context,
        child: SimpleDialog(
          title: Text("SELECCIONAR", textAlign: TextAlign.center),
          titlePadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          _open_gallery();
                          Navigator.pop(context, 'Lost');
                        },
                        // color: Colors.orange,
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.perm_media),
                            Text("Imágenes")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          _open_camera();
                          Navigator.pop(context, 'Lost');
                        },
                        // color: Colors.orange,
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.camera_alt),
                            Text("Cámara")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  void eliminarFoto( String id) {
    print('Eliminado foto');
    Foto _foto = Foto();
    _foto = this.favorito.fotos.firstWhere((item) => (item.id == id));
    bool resp = this.favorito.fotos.remove(_foto);
    print('Eliminada ${resp}');
  }

  Future<void> refresh() async {
    var _id = gastronomico.id;
    gastronomico = new Gastronomico();
    view(id: _id);
    isFavorito(_id);
  }
}
