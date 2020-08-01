import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';
import '../models/alojamiento.dart';

import '../route/arguments.dart';
import '../controllers/alojamiento.dart';
import '../widgets/CardAlojamientoWidget.dart';

class AlojamientosWidget extends StatefulWidget {
  RouteArgument routeArgument;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  AlojamientosWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _AlojamientosWidgetState createState() => _AlojamientosWidgetState();
}

class _AlojamientosWidgetState extends StateMVC<AlojamientosWidget> {
  AlojamientoController _con;
  List<Alojamiento> result_alojamientos = <Alojamiento>[];

  _AlojamientosWidgetState() : super(AlojamientoController()) {
    _con = controller;
  }

  @override
  void initState() {
    result_alojamientos = _con.alojamientos;
    super.initState();
  }

  void update_result() {
    result_alojamientos = _con.alojamientos
        .where((item) => _con.selectedItemsCategoria.isEmpty
            ? true
            : _con.selectedItemsCategoria
                .contains(int.parse(item.categoria.id) - 1))
        .toList()
        .where((item) => _con.selectedItemsClasificacion.isEmpty
            ? true
            : _con.selectedItemsClasificacion
                .contains(int.parse(item.clasificacion.id) - 1))
        .toList()
        .where((item) => _con.selectedItemsLocalidad.isEmpty
            ? true
            : _con.selectedItemsLocalidad
                .contains(int.parse(item.localidad.id) - 1))
        .toList();
  }

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
          title: Text('Alojamientos'),
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
                    items: _con.items_filter_categorias,
                    selectedItems: _con.selectedItemsCategoria,
                    keyboardType: TextInputType.number,
                    hint: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Select Categoria"),
                    ),
                    searchHint: "Select Categoria",
                    onChanged: (value) {
                      setState(() {
                        _con.selectedItemsCategoria = value;
                      });
                      print('Categorias filtradas: ' + value.toString());
                      update_result();
                    },
                    closeButton: 'Guardar',
                    doneButton: 'Cerrar',
                    isExpanded: true,
                  ),
                  SearchableDropdown.multiple(
                    items: _con.items_filter_clasificacion,
                    selectedItems: _con.selectedItemsClasificacion,
                    keyboardType: TextInputType.text,
                    hint: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Select Clasificacion"),
                    ),
                    searchHint: "Select Clasificacion",
                    onChanged: (value) {
                      setState(() {
                        _con.selectedItemsClasificacion = value;
                      });
                      print('Clasificaciones filtradas: ' + value.toString());
                      update_result();
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
                      update_result();
                    },
                    closeButton: 'Guardar',
                    doneButton: 'Cerrar',
                    isExpanded: true,
                  )
                ])
            : Column()
            ,
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: result_alojamientos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Alojamiento',
                          arguments: RouteArgument(
                              id: result_alojamientos.elementAt(index).id,
                              heroTag:
                                  result_alojamientos.elementAt(index).nombre));
                      print(
                          'Click en la ciudad: ${result_alojamientos.elementAt(index).nombre}');
                    },
                    child: CardAlojamientoWidget(
                        alojamiento: result_alojamientos.elementAt(index),
                        heroTag: 'alojamientos'),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
