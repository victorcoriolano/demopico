import 'package:demopico/features/mapa/data/services/local_storage_service.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_history_repository.dart';

class SaveHistoryUc {
  static SaveHistoryUc? _saveHistoryUc;
  static SaveHistoryUc get getInstance {
    _saveHistoryUc ??=
        SaveHistoryUc(historyRepositoryIMP: LocalStorageService.getInstance);
    return _saveHistoryUc!;
  }

  final IHistoryRepository historyRepositoryIMP;
  SaveHistoryUc({required this.historyRepositoryIMP});

  Future<void> execultaSalvar(String name, double lat, double long) async {
    try {
      await historyRepositoryIMP.salvarNoHistorico(name, lat, long);
    } catch (e) {
      throw Exception("Erro ao salvar no histórico: $e");
    }
  }

  Future<List<Map<String, dynamic>>?> execultaCarregar() async {
    try {
      final historico = await historyRepositoryIMP.carregarHistorico();
      if (historico.isEmpty) {
        return [];
      } else {
        return historico;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> execultaLimpar() async {
    try {
      await historyRepositoryIMP.limparHistorico();
    } catch (e) {
      throw Exception("Erro ao limpar o histórico: $e");
    }
  }

  Future<bool> execultaApagar(String nomeItem) async {
    try {
      await historyRepositoryIMP.deleteEntry(nomeItem);
      return true;
    } catch (e) {
      return false;
    }
  }
}
