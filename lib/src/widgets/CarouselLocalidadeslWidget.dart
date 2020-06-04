import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import '../models/localidad.dart';
import '../route/arguments.dart';
import 'CardLocalidadWidget.dart';

class CarouselLocalidadeslWidget extends StatefulWidget {
  List<Localidad> localidades;
  String heroTag;

  CarouselLocalidadeslWidget({Key key, this.localidades, this.heroTag}) : super(key: key);

  @override
  _CarouselLocalidadeslWidgetState createState() => _CarouselLocalidadeslWidgetState();
}

class _CarouselLocalidadeslWidgetState extends State<CarouselLocalidadeslWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 288,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.localidades.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushNamed('/Details',
                    //     arguments: RouteArgument(
                    //       id: widget.localidades.elementAt(index).id,
                    //       heroTag: widget.heroTag,
                    //     ));
                    print('Click en la ciudad: ${widget.localidades.elementAt(index).nombre}');
                  },
                  child: CardLocalidadWidget(localidad: widget.localidades.elementAt(index), heroTag: widget.heroTag),
                );
              },
            ),
          );
  }
}
