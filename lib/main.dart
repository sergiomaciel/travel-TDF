import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:travel_tdf/src/pages/pages.dart';
import 'src/controllers/controller.dart';

import 'src/pages/home.dart';
import 'src/pages/splash.dart';
import 'src/route/route_generator.dart';
 
Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

 
class MyApp extends AppMVC {

  MyApp({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel TDF',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      home: PagesWidget()
    );
  }
}