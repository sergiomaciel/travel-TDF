import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/favotito.dart';
import '../models/usuario.dart';
import '../repository/usuario.dart' as repository;
import '../config/api.dart';
import '../helpers/helper.dart';
import '../helpers/maps_util.dart';
import '../models/alojamiento.dart';
import '../repository/alojamiento.dart';
import '../models/gastronomico.dart';
import '../repository/gastronomico.dart' as repo_gastronomico;
import '../repository/settings.dart' as sett;

class MapController extends ControllerMVC {
  Usuario usuario = repository.currentUser.value;

  Alojamiento alojamiento;
  List<Alojamiento> alojamientos = <Alojamiento>[];

  Gastronomico gastronomico;
  List<Gastronomico> gastronomicos = <Gastronomico>[];

  Favorito favorito;
  List<Favorito> favoritos = <Favorito>[];
  List<DropdownMenuItem> items_filter = [];
  List<int> selectedItems = [];

  List<Marker> allMarkers = <Marker>[];
  LocationData currentLocation;
  Set<Polyline> polylines = new Set();
  CameraPosition cameraPosition;
  ApiRest api = ApiRest();
  MapsUtil mapsUtil = new MapsUtil();
  Completer<GoogleMapController> mapController = Completer();

  MapController() {
    this.favoritos = this.usuario.favoritos;
    alojamiento = Alojamiento();
    alojamiento.lat = '-54.810525';
    alojamiento.lng = '-68.3243295';
    
    setCurrentLocation();
    loadItems();
  }

  void listAlojamientos() async {
    final Stream<Alojamiento> stream = await getAlojamientos();
    stream.listen((Alojamiento _alojamiento) {
      setState(() {
        alojamientos.add(_alojamiento);
      });
      Helper.getMarkerAlojamiento(_alojamiento.toMap()).then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });
    }, onError: (a) {}, onDone: () {});
  }

  void listGastronomicos() async {
    repo_gastronomico.getGastronomicos().then((List<Gastronomico> data) {
      setState(() => gastronomicos = data);
      data.forEach((_gastronomico) {
        Helper.getMarkerGastronomico(_gastronomico.toMap()).then((marker) {
          setState(() {
            allMarkers.add(marker);
          });
        });
      });
    }, onError: (a) {
      print(a);
    });
  }

  void loadItems() {
    this
        .usuario
        .favoritos
        .forEach((data) => (this.items_filter.add(data.tipo == 'alojamiento'
            ? DropdownMenuItem(
                child: Text(data.alojamiento.nombre),
                value: data.alojamiento.nombre,
              )
            : DropdownMenuItem(
                child: Text(data.gastronomico.nombre),
                value: data.gastronomico.nombre,
              ))));
  }

  void update_result() {
    List<Favorito> result = selectedItems.isEmpty
        ? usuario.favoritos
        : usuario.favoritos
            .where((item) => selectedItems.contains(int.parse(item.id) - 1))
            .toList();

    setState(() => this.favoritos = result);
        this.usuario.favoritos.forEach((data) => (this.items_filter.add(
                  data.tipo == 'alojamiento'
                  ?  DropdownMenuItem(
                    child: Text(data.alojamiento.nombre),
                    value: data.alojamiento.nombre,
                  )
                  : DropdownMenuItem(
                    child: Text(data.gastronomico.nombre),
                    value: data.gastronomico.nombre,
                  )
                  ))); 

    this.favoritos.forEach((item){
      item.tipo == 'alojamiento'
      ? Helper.getMarkerFavorito(item.alojamiento.toMap()).then((marker) {        
          setState(() {
            allMarkers.add(marker);
          });
        })
      : Helper.getMarkerFavorito(item.gastronomico.toMap()).then((marker) {        
          setState(() {
            allMarkers.add(marker);
          });
        })
      ;
    });
  }

  void setCurrentLocation() async {
    try {
      LocationData nowLocation = await sett.setCurrentLocation();
      setState(() {
        currentLocation = nowLocation;
        cameraPosition = CameraPosition(
          // target: LatLng(nowLocation.latitude, nowLocation.longitude),
          target: LatLng(
              double.parse(alojamiento.lat), double.parse(alojamiento.lng)),
          zoom: 14.4746,
        );
      });
      Helper.getMyPositionMarker(
              double.parse(alojamiento.lat), double.parse(alojamiento.lng))
          .then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permiso denegado');
      }
    }
  }

  // void getCurrentLocation() async {
  //   try {
  //     currentLocation = await sett.getCurrentLocation();
  //     setState(() {
  //       cameraPosition = CameraPosition(
  //         target: LatLng(double.parse(alojamiento.lat), double.parse(alojamiento.lng)),
  //         zoom: 14.4746,
  //       );
  //     });
  //     Helper.getMyPositionMarker(double.parse(alojamiento.lat), double.parse(alojamiento.lng)).then((marker) {
  //       setState(() {
  //         allMarkers.add(marker);
  //       });
  //     });
  //   } on PlatformException catch (e) {
  //     if (e.code == 'PERMISSION_DENIED') {
  //       print('Permiso denegado');
  //     }
  //   }
  // }

  Future<void> goCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 14.4746,
    )));
  }

  void getAlojamientosOfArea() async {
    setState(() {
      alojamientos = <Alojamiento>[];
      LocationData areaLocation = LocationData.fromMap({
        "latitude": cameraPosition.target.latitude,
        "longitude": cameraPosition.target.longitude
      });
      if (cameraPosition != null) {
        listAlojamientos();
        // listAlojamientos(currentLocation, areaLocation);
      } else {
        listAlojamientos();
        // listAlojamientos(currentLocation, currentLocation);
      }
    });
  }

  void getDirectionSteps() async {
    currentLocation = await sett.getCurrentLocation();
    mapsUtil
        .get("origin=" +
            currentLocation.latitude.toString() +
            "," +
            currentLocation.longitude.toString() +
            "&destination=" +
            alojamiento.lat +
            "," +
            alojamiento.lng +
            "&key=${api.googleMapsKey()}")
        .then((dynamic res) {
      List<LatLng> _latLng = res as List<LatLng>;
      _latLng.insert(
          0, new LatLng(currentLocation.latitude, currentLocation.longitude));
      setState(() {
        polylines.add(new Polyline(
            visible: true,
            polylineId: new PolylineId(currentLocation.hashCode.toString()),
            points: _latLng,
            color: Colors.green,
            width: 6));
      });
    });
  }

  Future refreshMap() async {
    setState(() {
      alojamientos = <Alojamiento>[];
    });
    listAlojamientos();
  }
}
