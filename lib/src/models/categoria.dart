class Categoria {
  String id;
  String estrellas;
  int valor;

  Categoria();

  Categoria.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    estrellas = jsonMap['estrellas'];
    valor = jsonMap['valor'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'estrellas': estrellas,
      'valor': valor
    };
  }
}
