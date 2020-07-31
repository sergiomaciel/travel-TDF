import 'package:flutter/material.dart';

import 'CardGastronomicoHomeWidget.dart';
import '../models/gastronomico.dart';

class CarouselGastronomicosWidget extends StatelessWidget {
  List<Gastronomico> gastronomicos;

  CarouselGastronomicosWidget({Key key, this.gastronomicos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 150,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListView.builder(
              itemCount: gastronomicos.length,
              itemBuilder: (context, index) {
                double _marginLeft = 0;
                (index == 0) ? _marginLeft = 5 : _marginLeft = 0;
                return CardGastronomicoHomeWidget(
                  marginLeft: _marginLeft,
                  gastronomico: gastronomicos.elementAt(index),
                );
              },
              scrollDirection: Axis.horizontal,
            ));
  }
}
