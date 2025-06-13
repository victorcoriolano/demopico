class Filters {
  List<String>? utilidades;
  String? modalidade;
  String? tipo;
  double? raio;
  Map<String, int>? atributos;

  Filters({this.utilidades, this.modalidade, this.tipo, this.raio, this.atributos});

  bool get hasActivateFilters {
    return utilidades!.isNotEmpty || modalidade != null || raio != null || atributos!.isNotEmpty;
  }

  
}