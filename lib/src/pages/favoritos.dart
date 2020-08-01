import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../route/arguments.dart';
import '../controllers/favorito.dart';
import '../widgets/CardAlojamientoWidget.dart';
import '../widgets/CardGastronomicoWidget.dart';

class FavoritosWidget extends StatefulWidget {
  RouteArgument routeArgument;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  FavoritosWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _FavoritosWidgetState createState() => _FavoritosWidgetState();
}

class _FavoritosWidgetState extends StateMVC<FavoritosWidget> {
  FavoritoController _con;

  _FavoritosWidgetState() : super(FavoritoController()) {
    _con = controller;
  }

  // @override
  // void initState() {
  //   _con.result_gastronomico = _con.gastronomicos;
  //   super.initState();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => {}),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            )
          ],
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Gastronomicos'),
        ),
        key: _con.scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

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
                print('Establecimientos filtradas: ' + value.toString());
                // _con.update_result();
              },
              closeButton: 'Guardar',
              doneButton: 'Cerrar',
              isExpanded: true,
            ),

            // Expanded(
            //   child: ListView.builder(
            //     scrollDirection: Axis.vertical,
            //     itemCount: _con.gastronomicos.length,
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap: () {
            //           Navigator.of(context).pushNamed('/Favorito',
            //               arguments: RouteArgument(
            //                   id: _con.gastronomicos.elementAt(index).id,
            //                   param: 'gastronomico',
            //                   heroTag:_con.gastronomicos.elementAt(index).nombre));
            //           print(
            //               'Click en la ciudad: ${_con.gastronomicos.elementAt(index).nombre}');
            //         },
            //         child: CardGastronomicoWidget(
            //             gastronomico: _con.gastronomicos.elementAt(index),
            //             heroTag: 'gastronomico'),
            //       );
            //     },
            //   ),
            // ),

            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _con.alojamientos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Alojamiento',
                          arguments: RouteArgument(
                              id: _con.alojamientos.elementAt(index).id,
                              param: 'alojamiento',
                              heroTag:
                                   _con.alojamientos.elementAt(index).nombre));
                      print('Click en la Alojamiento Fav: ${ _con.alojamientos.elementAt(index).nombre}');
                    },
                    child: CardAlojamientoWidget(
                        alojamiento: _con.alojamientos.elementAt(index),
                        heroTag: 'alojamientos'),
                  );
                },
              ),
            ),

          ],
        ));
  }
}
