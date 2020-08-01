import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/setting.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
LocationData locationData;

Future<Setting> initSettings() async {
  Setting _setting = Setting();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  await prefs.setString('settings', json.encode(_setting.toMap()));
  setting.value = _setting;
  setting.notifyListeners();

  print("Init");
  return setting.value;
}

Future<LocationData> setCurrentLocation() async {
  print("serCurrentLocation");
  var location = new Location();
  location.requestService().then((value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      locationData = await location.getLocation();
      await prefs.setDouble('currentLat', locationData.latitude);
      await prefs.setDouble('currentLon', locationData.longitude);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permiso denegado');
      }
    }
  });
  return locationData;
}

Future<LocationData> getCurrentLocation() async {
  print("getCurrentLocation");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('currentLat') && prefs.containsKey('currentLon')) {
    locationData = LocationData.fromMap({"latitude": prefs.getDouble('currentLat'), "longitude": prefs.getDouble('currentLon')});
  } else {
    setCurrentLocation().then((value) {
      if (prefs.containsKey('currentLat') && prefs.containsKey('currentLon')) {
        locationData = LocationData.fromMap({"latitude": prefs.getDouble('currentLat'), "longitude": prefs.getDouble('currentLon')});
      }
    });
  }
  return locationData;
}