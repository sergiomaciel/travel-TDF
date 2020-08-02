import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/foto.dart';
import '../models/favotito.dart';

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

  Favorito favorito = Favorito();
  bool esFavorito = false;
  File _image;
  bool filtros = false;

  List<DropdownMenuItem> items_filter_categorias = [];
  List<int> selectedItemsCategoria = [];
  List<DropdownMenuItem> items_filter_clasificacion = [];
  List<int> selectedItemsClasificacion = [];
  List<DropdownMenuItem> items_filter_localidad = [];
  List<int> selectedItemsLocalidad = [];
  
  GlobalKey<ScaffoldState> scaffoldKey;

  AlojamientoController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    list();
    loadItemsCategoria();
    loadItemsClasificacion();
    loadItemsLocalidad();
  }

  void view({String id, String msg}) async {
    final Stream<Alojamiento> stream =
        await repository_alojamiento.getAlojamiento(id);
    stream.listen((Alojamiento _alojamiento) {
      setState(() => alojamiento = _alojamiento);
      isFavorito(_alojamiento.id);
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

  void list() async {
    final Stream<Alojamiento> stream =
        await repository_alojamiento.getAlojamientos();
    stream.listen((Alojamiento _alojamiento) {
      setState(() => alojamientos.add(_alojamiento));
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    }, onDone: () {});
  }

  // void loadLocalidad(String id) async {
  //   Stream<Localidad> stream = await repository_localidad.getLocalidad(id);
  //   stream.listen((Localidad _res) {
  //     setState(() => alojamiento.setLocalidad(_res));
  //   });
  // }

  void loadItemsLocalidad() async {
    final Stream<Localidad> stream = await repository_localidad.getLocalidades();
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

  // void loadCategoria(String id) async {
  //   Stream<Categoria> stream = await repository_categoria.getCategoria(id);
  //   stream.listen((Categoria _res) {
  //     setState(() => alojamiento.setCategoria(_res));
  //   });
  // }

  void loadItemsCategoria() async {
    final Stream<Categoria> stream = await repository_categoria.getCategorias();
    stream.listen((Categoria _categoria) {
      setState(() => items_filter_categorias.add(DropdownMenuItem(
            child: Text(_categoria.estrellas),
            value: _categoria.estrellas,
          )));
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    }, onDone: () {});
  }  

  // void loadClasificacion(String id) async {
  //   Stream<Clasificacion> stream =
  //       await repository_clasificacion.getClasificacion(id);
  //   stream.listen((Clasificacion _res) {
  //     setState(() => alojamiento.setClasificacion(_res));
  //   });
  // }

  void loadItemsClasificacion() async {
    final Stream<Clasificacion> stream = await repository_clasificacion.getClasificaciones();
    stream.listen((Clasificacion _clasificacion) {
      setState(() => items_filter_clasificacion.add(DropdownMenuItem(
            child: Text(_clasificacion.nombre),
            value: _clasificacion.nombre,
          )));
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Internet'),
      ));
    }, onDone: () {});
  }

  void isFavorito(String id) async {
    repository_alojamiento.isFavorito(id).then((Favorito _favorito) {
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
    repository_alojamiento.addFavorito(this.alojamiento).then(( Favorito value) {
      setState(() {
        this.favorito = value;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Alojamiento agregado a favoritos'),
      ));
      isFavorito(alojamiento.id);
    });
  }

  void eliminarFavorite(String id) async {
    repository_alojamiento.removeFavorito(id).then((value) {
      setState(() {
        this.favorito = new Favorito();
        this.esFavorito = false;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Alojamiento eliminado de favoritos'),
      ));
      isFavorito(alojamiento.id);
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
    var _id = alojamiento.id;
    alojamiento = new Alojamiento();
    view(id: _id);
    isFavorito(_id);
  }
}
