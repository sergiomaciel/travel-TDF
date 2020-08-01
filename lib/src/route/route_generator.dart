import 'package:flutter/material.dart';

import '../pages/alojamiento.dart';
import '../pages/gastronomico.dart';
import '../pages/splash.dart';
import './arguments.dart';
import '../pages/pages.dart';
import '../pages/home.dart';
import '../pages/map.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => PagesWidget());
      case 'Pages':
        return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
      case '/Alojamiento':
        return MaterialPageRoute(builder: (_) => AlojamientoWidget(routeArgument: args as RouteArgument));
      case '/Gastronomico':
        return MaterialPageRoute(builder: (_) => GastronomicoWidget(routeArgument: args as RouteArgument));
      case '/Map':
        return MaterialPageRoute(builder: (_) => MapWidget());
      case '/Splash':
        return MaterialPageRoute(builder: (_) => Splash());
      default:
        return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
