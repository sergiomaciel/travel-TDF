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
  String _urlBase = 'http://192.168.99.100:4000/v1/graphql';
  String _google_maps_key = '';

  @override
  String url() {
    return _urlBase;
  }

  String googleMapsKey() {
    return _google_maps_key;
  }

  String listGastronomicos = """
  query GastronomicosQuery {
    gastronomicos {
      id
      nombre
      domicilio
      foto
      lat
      lng
      actividad_gastronomicos {
        actividade {
          id
          nombre
        }
      }
      especialidad_gastronomicos {
        especialidade {
          id
          nombre
        }
      }
      localidade {
        id
        nombre
      }
    }
  }
""";

  String getGastronomico(int id ) {
    return """
  query GastronomicoQuery {
    gastronomicos_by_pk(id: ${id}) {
      id
      domicilio
      lat
      lng
      actividad_gastronomicos {
        actividade {
          id
          nombre
        }
      }
      especialidad_gastronomicos {
        especialidade {
          id
          nombre
        }
      }
      localidade {
        id
        nombre
      }
      nombre
      foto
    }
  }
""";
  }
}
