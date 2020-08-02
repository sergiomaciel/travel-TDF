import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/foto.dart';

import '../helpers/helper.dart';
import '../route/arguments.dart';

class CardFotoWidget extends StatelessWidget {
  Foto foto;
  String heroTag;

  CardFotoWidget({Key key, this.foto, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Image of the card
          Hero(
            tag: heroTag,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: foto.local == null
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: 'futura_url',
                        placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                            ),
                        errorWidget: (context, url, error) => Image.asset(
                              'assets/img/loading.png',
                              fit: BoxFit.cover,
                            ))
                    : Image.file(foto.local, height: 200, fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        foto.fecha,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.redAccent[200],
                          size: 30,
                        ),
                        tooltip: 'Agregar Foto',
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Deslizar para eliminar")));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
