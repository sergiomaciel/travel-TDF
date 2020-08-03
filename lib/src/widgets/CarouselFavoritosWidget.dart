import 'package:flutter/material.dart';

import 'CardGastronomicoHomeWidget.dart';
import 'CardAlojamientoHomeWidget.dart';
import '../models/favotito.dart';

class CarouselFavoritosWidget extends StatelessWidget {
  List<Favorito> favoritos;

  CarouselFavoritosWidget({Key key, this.favoritos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 150,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                double _marginLeft = 0;
                (index == 0) ? _marginLeft = 5 : _marginLeft = 0;
                return favoritos.elementAt(index).tipo == 'gastronomico'
                ? CardGastronomicoHomeWidget(
                  marginLeft: _marginLeft,
                  gastronomico: favoritos.elementAt(index).gastronomico,
                )
                : CardAlojamientoHomeWidget(
                  marginLeft: _marginLeft,
                  alojamiento: favoritos.elementAt(index).alojamiento,
                )
                ;
              },
              scrollDirection: Axis.horizontal,
            ));
  }
}
