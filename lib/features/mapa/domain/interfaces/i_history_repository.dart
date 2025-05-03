
abstract  class IHistoryRepository {
  Future<void> salvarNoHistorico(String nome, double lat, double long);
  Future<List<Map<String, dynamic>>> carregarHistorico();
  Future<void> deleteEntry(String nome);
  Future<void> limparHistorico();
}