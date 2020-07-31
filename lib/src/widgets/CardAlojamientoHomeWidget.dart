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
      child: Container(
        width: 150,
        margin: EdgeInsetsDirectional.only(start: this.marginLeft, end: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: <Widget>[
                Hero(
                  tag: alojamiento.id + alojamiento.nombre,
                  child: Container(
                    width: 150,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
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
                  margin: EdgeInsetsDirectional.only(end: 5, top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)), 
                    color: Colors.black.withOpacity(0.5)
                    ),
                  child: Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20
                    ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsetsDirectional.only(start: 10, end: 10),
                alignment: AlignmentDirectional.center,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      this.alojamiento.nombre,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    // Text(
                    //   this.alojamiento.localidad.nombre,
                    //   overflow: TextOverflow.fade,
                    //   softWrap: false,
                    //   style: TextStyle(fontSize: 12),
                    // ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
