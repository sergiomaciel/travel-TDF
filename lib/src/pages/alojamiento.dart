import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route/arguments.dart';

import '../controllers/alojamiento.dart';

class AlojamientoWidget extends StatefulWidget {
  RouteArgument routeArgument;

  AlojamientoWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _AlojamientoWidgetState createState() => _AlojamientoWidgetState();
}

class _AlojamientoWidgetState extends StateMVC<AlojamientoWidget> {

  AlojamientoController _con;

  _AlojamientoWidgetState() : super(AlojamientoController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.view(id: widget.routeArgument.id, msg: widget.routeArgument.heroTag);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      key: _con.scaffoldKey,
      body: RefreshIndicator(
              onRefresh: _con.refresh,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    // margin: EdgeInsets.only(bottom: 120),
                    // padding: EdgeInsets.only(bottom: 15),
                    child: CustomScrollView(
                      primary: true,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        SliverAppBar(
                          backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                          expandedHeight: 300,
                          elevation: 0,
                          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Hero(
                              tag: widget.routeArgument.heroTag,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: _con.alojamiento.foto,
                                placeholder: (context, url) => Image.asset(
                                  'assets/img/loading.gif',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            child: Wrap(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _con.alojamiento.nombre,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context).textTheme.display2,
                                          ),
                                          Text(
                                            _con.alojamiento.getLocalidad().nombre,
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            style: Theme.of(context).textTheme.body1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          // Helper.getPrice(
                                          //   _con.food.price,
                                          //   context,
                                          //   style: Theme.of(context).textTheme.display3,
                                          // ),
                                          // Text(
                                          //   _con.food.weight + S.of(context).g,
                                          //   overflow: TextOverflow.ellipsis,
                                          //   maxLines: 1,
                                          //   style: Theme.of(context).textTheme.body1,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  leading: Icon(
                                    Icons.map,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  title: Text(
                                    'Clasificación',
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ),
                                // ListView.separated(
                                //   padding: EdgeInsets.all(0),
                                //   itemBuilder: (context, index) {
                                //     return ExtraItemWidget(
                                //       extra: _con.food.extras.elementAt(index),
                                //       onChanged: _con.calculateTotal,
                                //     );
                                //   },
                                //   separatorBuilder: (context, index) {
                                //     return SizedBox(height: 20);
                                //   },
                                //   itemCount: _con.food.extras.length,
                                //   primary: false,
                                //   shrinkWrap: true,
                                // ),
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  leading: Icon(
                                    Icons.map,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  title: Text(
                                    'Mapa',
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ),
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  leading: Icon(
                                    Icons.camera,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  title: Text(
                                    'Mis Fotos',
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}