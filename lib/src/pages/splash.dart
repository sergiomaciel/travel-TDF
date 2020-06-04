import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends StateMVC<Splash> {

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {

    // Future.delayed(const Duration(seconds: 5), () => (
    //   Navigator.of(context).pushReplacementNamed('/Home', arguments: 2)
    // ));

    Navigator.of(context).pushReplacementNamed('/Home', arguments: 2);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   'assets/img/logo.png',
              //   width: 150,
              //   fit: BoxFit.cover,
              // ),
              // SizedBox(height: 50),
              // CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
