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

  @override
  void initState() {
    // _con.loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).hintColor,
              ),
              onPressed: () => {}),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            )
          ],
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text('Favoritos'),
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
                _con.update_result();
              },
              closeButton: 'Filtrar',
              doneButton: 'Cerrar',
              isExpanded: true,
            ),

            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _con.favoritos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _con.favoritos.elementAt(index).tipo == 'gastronomico'
                      ? Navigator.of(context).pushNamed('/Gastronomico',
                          arguments: RouteArgument(
                              id: _con.favoritos.elementAt(index).gastronomico.id,
                              heroTag: _con.favoritos.elementAt(index).gastronomico.nombre))
                      : Navigator.of(context).pushNamed('/Alojamiento',
                          arguments: RouteArgument(
                              id: _con.favoritos.elementAt(index).alojamiento.id,
                              heroTag: _con.favoritos.elementAt(index).alojamiento.nombre))
                      ;
                    },
                    child: _con.favoritos.elementAt(index).tipo == 'gastronomico'
                    ? CardGastronomicoWidget(
                        gastronomico: _con.favoritos.elementAt(index).gastronomico,
                        heroTag: 'gastronomico')
                    :  CardAlojamientoWidget(
                        alojamiento: _con.favoritos.elementAt(index).alojamiento,
                        heroTag: 'alojamiento')
                    ,
                  );
                },
              ),
            ),

          ],
        ));
  }
}
