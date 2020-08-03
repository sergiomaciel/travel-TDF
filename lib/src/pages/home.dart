import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route/arguments.dart';
import '../controllers/home.dart';

import '../widgets/CarouselLocalidadeslWidget.dart';
import '../widgets/CarouselAlojamientosWidget.dart';
import '../widgets/CarouselGastronomicosWidget.dart';

class HomeWidget extends StatefulWidget {
  RouteArgument routeArgument;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  HomeController _con;

  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.menu, color: Theme.of(context).hintColor),
            onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Travel TDF',
            style: Theme.of(context)
                .textTheme
                .title
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.favorite),
            //   color: Colors.redAccent[400],
            //   onPressed: () {
            //     //  Navigator.of(context).pushReplacementNamed('/Pages', arguments: 3);
            //   },
            // )
          ],
        ),
        body: SingleChildScrollView(
            // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 20),
              child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  title: Text(
                    'Ciudades',
                    style: Theme.of(context).textTheme.title,
                  )),
            ),
            CarouselLocalidadeslWidget(
                localidades: _con.localidades, heroTag: 'localidades_home'),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 20),
              child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  title: Text(
                    'Alojamientos',
                    style: Theme.of(context).textTheme.title,
                  )),
            ),
            CarouselAlojamientosWidget(alojamientos: _con.alojamientos),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 20),
              child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  title: Text(
                    'Gastronomía',
                    style: Theme.of(context).textTheme.title,
                  )),
            ),
            CarouselGastronomicosWidget(gastronomicos: _con.gastronomicos),
          ],
        )));
  }
}
