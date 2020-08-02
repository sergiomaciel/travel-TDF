import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../route/arguments.dart';
import '../models/gastronomico.dart';
import '../controllers/gastronomico.dart';
import '../widgets/CardGastronomicoWidget.dart';

class GastronomicosWidget extends StatefulWidget {
  RouteArgument routeArgument;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  GastronomicosWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _GastronomicosWidgetState createState() => _GastronomicosWidgetState();
}

class _GastronomicosWidgetState extends StateMVC<GastronomicosWidget> {
  GastronomicoController _con;

  _GastronomicosWidgetState() : super(GastronomicoController()) {
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
              onPressed: () {
                setState(() {
                  _con.filtros = !_con.filtros;
                });
              },
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
            _con.filtros
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      
                        SearchableDropdown.multiple(
                          items: _con.items_filter_actividad,
                          selectedItems: _con.selectedItemsActividad,
                          keyboardType: TextInputType.number,
                          hint: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("Select Actividad"),
                          ),
                          searchHint: "Select Actividad",
                          onChanged: (value) {
                            setState(() {
                              _con.selectedItemsActividad = value;
                            });
                            print('Actividades filtradas: ' + value.toString());
                            _con.update_result();
                          },
                          closeButton: 'Guardar',
                          doneButton: 'Cerrar',
                          isExpanded: true,
                        ),

                        SearchableDropdown.multiple(
                          items: _con.items_filter_especialidad,
                          selectedItems: _con.selectedItemsEspecialidad,
                          keyboardType: TextInputType.text,
                          hint: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("Select Especialidad"),
                          ),
                          searchHint: "Select Especialidad",
                          onChanged: (value) {
                            setState(() {
                              _con.selectedItemsEspecialidad = value;
                            });
                            print('Especialidades filtradas: ' + value.toString());
                            _con.update_result();
                          },
                          closeButton: 'Guardar',
                          doneButton: 'Cerrar',
                          isExpanded: true,
                        ),

                        SearchableDropdown.multiple(
                          items: _con.items_filter_localidad,
                          selectedItems: _con.selectedItemsLocalidad,
                          keyboardType: TextInputType.text,
                          hint: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("Select Localidad"),
                          ),
                          searchHint: "Select Localidad",
                          onChanged: (value) {
                            setState(() {
                              _con.selectedItemsLocalidad = value;
                            });
                            print('Localidades filtradas: ' + value.toString());
                            _con.update_result();
                          },
                          closeButton: 'Guardar',
                          doneButton: 'Cerrar',
                          isExpanded: true,
                        ),
                      ])
                : Column(),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _con.result_gastronomico.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Gastronomico',
                          arguments: RouteArgument(
                              id: _con.result_gastronomico.elementAt(index).id,
                              heroTag: _con.result_gastronomico
                                  .elementAt(index)
                                  .nombre));
                      print(
                          'Click en la ciudad: ${_con.result_gastronomico.elementAt(index).nombre}');
                    },
                    child: CardGastronomicoWidget(
                        gastronomico: _con.result_gastronomico.elementAt(index),
                        heroTag: 'gastronomico'),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
