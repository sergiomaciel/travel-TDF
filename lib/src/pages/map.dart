import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import '../route/route_generator.dart';

import '../widgets/CarouselFavoritosWidget.dart';
import '../widgets/CarouselGastronomicosWidget.dart';
import '../widgets/CarouselAlojamientosWidget.dart';

import '../controllers/map.dart';

import '../route/arguments.dart';

class MapWidget extends StatefulWidget {
  RouteArgument routeArgument;

  MapWidget({Key key}) : super(key: key);
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends StateMVC<MapWidget> {
  MapController _con;

  _MapWidgetState() : super(MapController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  bottom: TabBar(
                    tabs: [
                      Tab(
                          icon: Icon(
                        Icons.domain,
                        color: Theme.of(context).accentColor,
                      )),
                      Tab(
                          icon: Icon(
                        Icons.local_dining,
                        color: Theme.of(context).accentColor,
                      )),
                      Tab(
                          icon: Icon(
                        Icons.favorite,
                        color: Theme.of(context).accentColor,
                      )),
                    ],
                  ),
                  title: Text(
                    'Mapa',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .merge(TextStyle(letterSpacing: 1.3)),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.my_location,
                        color: Theme.of(context).hintColor,
                      ),
                      onPressed: () {
                        _con.goCurrentLocation();
                      },
                    )
                  ],
                ),
                body: TabBarView(
                  children: [
                    Stack(
                      // fit: StackFit.expand,
                      alignment: AlignmentDirectional.bottomStart,
                      children: <Widget>[
                        GoogleMap(
                          mapToolbarEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition: _con.cameraPosition,
                          markers: Set.from(_con.allMarkers),
                          onMapCreated: (GoogleMapController controller) {
                            _con.mapController.complete(controller);
                          },
                          onCameraMove: (CameraPosition cameraPosition) {
                            _con.cameraPosition = cameraPosition;
                          },
                          onCameraIdle: () {
                            // _con.getAlojamientosOfArea();
                            setState(() => _con.allMarkers = []);
                            _con.listAlojamientos();
                          },
                          polylines: _con.polylines,
                        ),
                        CarouselAlojamientosWidget(
                          alojamientos: _con.alojamientos,
                        ),
                      ],
                    ),
                    Stack(
                      // fit: StackFit.expand,
                      alignment: AlignmentDirectional.bottomStart,
                      children: <Widget>[
                        GoogleMap(
                          mapToolbarEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition: _con.cameraPosition,
                          markers: Set.from(_con.allMarkers),
                          onMapCreated: (GoogleMapController controller) {
                            _con.mapController.complete(controller);
                          },
                          onCameraMove: (CameraPosition cameraPosition) {
                            _con.cameraPosition = cameraPosition;
                          },
                          onCameraIdle: () {
                            // _con.getAlojamientosOfArea();
                            setState(() => _con.allMarkers = []);
                            _con.listGastronomicos();
                          },
                          polylines: _con.polylines,
                        ),
                        CarouselGastronomicosWidget(
                          gastronomicos: _con.gastronomicos,
                        ),
                      ],
                    ),
                    Stack(
                      // fit: StackFit.expand,
                      alignment: AlignmentDirectional.bottomStart,
                      children: <Widget>[
                        GoogleMap(
                          mapToolbarEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition: _con.cameraPosition,
                          markers: Set.from(_con.allMarkers),
                          onMapCreated: (GoogleMapController controller) {
                            _con.mapController.complete(controller);
                          },
                          onCameraMove: (CameraPosition cameraPosition) {
                            _con.cameraPosition = cameraPosition;
                          },
                          onCameraIdle: () {
                            // _con.getAlojamientosOfArea();
                            setState(() => _con.allMarkers = []);
                            _con.update_result();
                          },
                          polylines: _con.polylines,
                        ),
                        CarouselFavoritosWidget(
                          favoritos: _con.favoritos,
                        ),
                        SearchableDropdown.multiple(
                          items: _con.items_filter,
                          selectedItems: _con.selectedItems,
                          keyboardType: TextInputType.text,
                          hint: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("Select Establecimiento"),
                          ),
                          searchHint: "Select Establecimiento",
                          onChanged: (value) {
                            setState(() {
                              _con.selectedItems = value;
                            });
                            print('Establecimientos filtradas: ' +
                                value.toString());
                            _con.update_result();
                          },
                          closeButton: 'Filtrar',
                          doneButton: 'Cerrar',
                          isExpanded: true,
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
