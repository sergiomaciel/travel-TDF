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
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white,),
          onPressed: () => {}
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('TRAVEL TDF'),
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
                )
              ),
            ),
            CarouselLocalidadeslWidget(localidades: _con.localidades, heroTag: 'localidades_home'),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 20),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                title: Text(
                  'Alojamientos',
                  style: Theme.of(context).textTheme.title,
                )
              ),
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
                )
              ),
            ),
            CarouselGastronomicosWidget(gastronomicos: _con.gastronomicos),
          ],
        )
      )
       
    );
  }
}