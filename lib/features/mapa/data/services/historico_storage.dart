import 'package:shared_preferences/shared_preferences.dart';

class HistoricoStorage {
  static const String _historicoKey = 'historico_picos';

  Future<void> salvarPico(String nome, double latitude, double longitude) async {
    final prefs = await SharedPreferences.getInstance();

    final historico = prefs.getStringList(_historicoKey) ?? [];

    historico.add('$nome,$latitude,$longitude');


    await prefs.setStringList(_historicoKey, historico);
  }

  Future<List<Map<String, dynamic>>> carregarHistorico() async {
    final prefs = await SharedPreferences.getInstance();

    final historico = prefs.getStringList(_historicoKey) ?? [];
    return historico.map((entry) {
      final data = entry.split(',');
      return {
        'nome': data[0],
        'latitude': double.parse(data[1]),
        'longitude': double.parse(data[2]),
      };
    }).toList();
  }

  Future<void> deleteEntry(String nome) async {
    final prefs = await SharedPreferences.getInstance();

    final historico = prefs.getStringList(_historicoKey);

    if(historico != null){
      final refere = historico.indexWhere((value) => value.contains(nome));
      historico.removeAt(refere);
    }

  }

  Future<void> limparHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historicoKey);
  }
}
