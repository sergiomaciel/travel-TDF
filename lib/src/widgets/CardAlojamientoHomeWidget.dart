import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../route/arguments.dart';
import '../models/alojamiento.dart';

class CardAlojamientoHomeWidget extends StatelessWidget {
  double marginLeft;
  Alojamiento alojamiento;
  
  CardAlojamientoHomeWidget({Key key, this.marginLeft, this.alojamiento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.white,
      onTap: () {
        Navigator.of(context).pushNamed('/Alojamiento', arguments: RouteArgument(id: alojamiento.id, heroTag: alojamiento.nombre));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Hero(
                tag: alojamiento.id + alojamiento.nombre,
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: this.marginLeft, end: 5),
                  width: 150,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: CachedNetworkImage(
                      height: 200,
                      fit: BoxFit.cover,
                      imageUrl: alojamiento.foto,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(end: 25, top: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)), 
                  color: Colors.black.withOpacity(0.5)
                  ),
                alignment: AlignmentDirectional.topEnd,
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 20
                  ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
              width: 125,
              margin: EdgeInsetsDirectional.only(start: this.marginLeft, end: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    this.alojamiento.nombre,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    this.alojamiento.getLocalidad().nombre,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
