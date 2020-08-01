import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api.dart';
import '../models/usuario.dart';

final Api api = ApiRest();
ValueNotifier<Usuario> currentUser = new ValueNotifier(Usuario());

Future<Usuario> login(Usuario user) async {
  final String url = '${api.url()}login';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = Usuario.fromJSON(json.decode(response.body)['data']);
  }

  return currentUser.value;
}

Future<Usuario> register(Usuario user) async {
  final String url = '${api.url()}registro';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = Usuario.fromJSON(json.decode(response.body)['data']);
  }
  return currentUser.value;
}

Future<bool> resetPassword(Usuario user) async {
  final String url = '${api.url()}send_reset_link_email';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body)['data']);
    return true;
  } else {
    return false;
  }
}

Future<void> logout() async {
  currentUser.value = new Usuario();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['data'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'current_user', json.encode(json.decode(jsonString)['data']));
  }
}

Future<Usuario> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value =
        Usuario.fromJSON(json.decode(await prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    dynamic userjson = {
      "id": "1",
      "favoritos": [
        {
          "id": 1,
          "tipo": "gastronomico",
          "id_establecimiento": "2",
          "alojamiento": {"id": 1},
          "gastronomico": null,
          "fotos": []
        },
        {
          "id": 2,
          "tipo": "gastronomico",
          "id_establecimiento": "4",
          "alojamiento": {"id": 1},
          "gastronomico": null,
          "fotos": []
        },
        {
          "id": 3,
          "tipo": "alojamiento",
          "id_establecimiento": "8",
          "alojamiento": {"id": 1},
          "gastronomico": null,
          "fotos": []
        }
      ]
    };
    await prefs.setString('current_user', json.encode(userjson));
    currentUser.value = Usuario.fromJSON(userjson);
    currentUser.value.auth = false;
  }
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<Usuario> update(Usuario user) async {
  // final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // final String url = '${api.url()}users/${currentUser.value.id}?$_apiToken';
  // final client = new http.Client();
  // final response = await client.post(
  //   url,
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //   body: json.encode(user.toMap()),
  // );
  // setCurrentUser(response.body);
  // currentUser.value = Usuario.fromJSON(json.decode(response.body)['data']);

  currentUser.value = user;
  return currentUser.value;
}
