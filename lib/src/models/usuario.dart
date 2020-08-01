
import '../models/favotito.dart';

class Usuario {
  String id;
  List<Favorito> favoritos;

  bool auth;
  String apiToken;
  String deviceToken;
  
  Usuario();

  Usuario.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap["id"].toString();
    apiToken = jsonMap['api_token'];
    deviceToken = jsonMap['device_token'];

    favoritos = jsonMap['favoritos'] != null ? List.from(jsonMap['favoritos']).map((element) => Favorito.fromJSON(element)).toList() : [];
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id == null ? null : id;
    map["favoritos"] = favoritos == null ? null : favoritos;
    map["api_token"] = apiToken == null ? null : apiToken;

    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    return map;
  }
}