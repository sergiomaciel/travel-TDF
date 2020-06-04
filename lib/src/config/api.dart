abstract class Api {
  String _urlBase;
  String _google_maps_key;

  String url();
  String googleMapsKey();
}

class ApiRest implements Api {

  String _urlBase = 'http://192.168.99.100:3000/';
  String _google_maps_key = 'AIzaSyBFmqr3-aJp23CM3BZPnPqH4nMh9SlgR1Q';

  @override
  String url() {
    return _urlBase;
  }

  String googleMapsKey() {
    return _google_maps_key;
  }
}

class GraphQl implements Api {

  String _urlBase = '';
  String _google_maps_key = '';

  @override
  String url() {
    return _urlBase;
  }

  String googleMapsKey() {
    return _google_maps_key;
  }
}