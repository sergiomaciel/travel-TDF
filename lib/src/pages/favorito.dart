import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route/arguments.dart';

import '../controllers/gastronomico.dart';

class GastronomicoWidget extends StatefulWidget {
  RouteArgument routeArgument;

  GastronomicoWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _GastronomicoWidgetState createState() => _GastronomicoWidgetState();
}

class _GastronomicoWidgetState extends StateMVC<GastronomicoWidget> {
  GastronomicoController _con;

  _GastronomicoWidgetState() : super(GastronomicoController()) {
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
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(0.9),
                    expandedHeight: 300,
                    elevation: 0,
                    iconTheme:
                        IconThemeData(color: Theme.of(context).primaryColor),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Hero(
                        tag: widget.routeArgument.heroTag,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: _con.gastronomico.foto,
                          placeholder: (context, url) => Image.asset(
                            'assets/img/loading.gif',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
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
                                      _con.gastronomico.nombre,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.display1,
                                    ),
                                    Text(
                                      _con.gastronomico.localidad.nombre,
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
                          // ListTile(
                          //   dense: true,
                          //   contentPadding: EdgeInsets.symmetric(vertical: 10),
                          //   leading: Icon(
                          //     Icons.star,
                          //     color: Theme.of(context).hintColor,
                          //   ),
                          //   title: Text(
                          //     'Categoria',
                          //     style: Theme.of(context).textTheme.subhead,
                          //   ),
                          //   subtitle: Text(
                          //     _con.gastronomico.getCategoria().estrellas,
                          //     style: Theme.of(context).textTheme.caption,
                          //   ),
                          // ),

                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            leading: Icon(
                              Icons.accessibility_new,
                              color: Theme.of(context).hintColor,
                            ),
                            title: Text(
                              'Actividades',
                              style: Theme.of(context).textTheme.subhead,
                            ),
                          ),
                          ListView.separated(
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              return Text(' - '+_con.gastronomico.actividades.elementAt(index).nombre);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 20);
                            },
                            itemCount: _con.gastronomico.actividades.length,
                            primary: false,
                            shrinkWrap: true,
                          ),

                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            leading: Icon(
                              Icons.format_list_bulleted,
                              color: Theme.of(context).hintColor,
                            ),
                            title: Text(
                              'Especialidades',
                              style: Theme.of(context).textTheme.subhead,
                            ),
                          ),
                          ListView.separated(
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              return Text(' - '+_con.gastronomico.especialidades.elementAt(index).nombre);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 20);
                            },
                            itemCount: _con.gastronomico.especialidades.length,
                            primary: false,
                            shrinkWrap: true,
                          ),

                          // ListTile(
                          //   dense: true,
                          //   contentPadding: EdgeInsets.symmetric(vertical: 10),
                          //   leading: Icon(
                          //     Icons.map,
                          //     color: Theme.of(context).hintColor,
                          //   ),
                          //   title: Text(
                          //     'Mapa',
                          //     style: Theme.of(context).textTheme.subhead,
                          //   ),
                          // ),
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
