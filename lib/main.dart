import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:travel_tdf/src/pages/pages.dart';
import 'src/controllers/controller.dart';

import 'src/route/route_generator.dart';
import 'src/helpers/app_config.dart' as config;
import 'src/models/setting.dart';
import 'src/repository/settings.dart' as settingRepo;
import 'src/repository/usuario.dart' as userRepo;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    settingRepo.initSettings();
    settingRepo.getCurrentLocation();
    userRepo.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
          fontFamily: 'Poppins',
          primaryColor: config.Colors().mainColor(1),
          accentColor: config.Colors().accentColor(1),
          focusColor: config.Colors().secondColor(1),
          hintColor: config.Colors().secondColor(1),
          scaffoldBackgroundColor: config.Colors().scaffoldColor(1),
          brightness: brightness,
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
            display1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
            display2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600, color: Colors.black),
            display3: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700, color: Colors.black),
            display4: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w300, color: config.Colors().secondColor(1)),
            subhead: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.black54),
            title: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().accentColor(1)),
            body1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black54),
            body2: TextStyle(fontSize: 16.0, color: config.Colors().secondColor(1)),
            caption: TextStyle(fontSize: 12.0, color: config.Colors().accentColor(1)),
          ),
        ),
        themedWidgetBuilder: (context, theme) {
          return ValueListenableBuilder(
              valueListenable: settingRepo.setting,
              builder: (context, Setting _setting, _) {
                return MaterialApp(
                  title: _setting.appName,
                  initialRoute: '/Pages',
                  onGenerateRoute: RouteGenerator.generateRoute,
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                );
              });
        });
  }
}
