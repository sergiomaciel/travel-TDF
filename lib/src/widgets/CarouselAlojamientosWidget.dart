import 'package:flutter/material.dart';

import 'CardAlojamientoHomeWidget.dart';
import '../models/alojamiento.dart';

class CarouselAlojamientosWidget extends StatelessWidget {
  List<Alojamiento> alojamientos;

  CarouselAlojamientosWidget({Key key, this.alojamientos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 150,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListView.builder(
              itemCount: alojamientos.length,
              itemBuilder: (context, index) {
                double _marginLeft = 0;
                (index == 0) ? _marginLeft = 5 : _marginLeft = 0;
                return CardAlojamientoHomeWidget(
                  marginLeft: _marginLeft,
                  alojamiento: alojamientos.elementAt(index),
                );
              },
              scrollDirection: Axis.horizontal,
            ));
  }
}
