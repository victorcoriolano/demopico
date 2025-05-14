import 'package:demopico/features/mapa/domain/usecases/save_history_spot_uc.dart';
import 'package:flutter/material.dart';

class HistoricoController extends ChangeNotifier {
  final SaveHistoryUc useCase;

  List<Map<String, dynamic>> _historico = [];
  List<Map<String, dynamic>> get historico => _historico;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HistoricoController(this.useCase) {
    carregarHistoricoInicial();
  }

  void carregarHistoricoInicial() async {
    _isLoading = true;
    notifyListeners();

    _historico = await useCase.execultaCarregar() ?? [];
    _isLoading = false;
    notifyListeners();
  }

  Future<void> salvarNoHistorico(String name, double lat, double long) async {
    _isLoading = true;
    notifyListeners();

    await useCase.execultaSalvar(name, lat, long);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> limparHistorico() async {
    _isLoading = true;
    notifyListeners();

    await useCase.execultaLimpar();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _historico.clear();
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> apagarItem(String nomeItem) async {
    _isLoading = true;
    notifyListeners();

    final sucesso = await useCase.execultaApagar(nomeItem);
    if (sucesso) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _historico.removeWhere((item) => item['nome'] == nomeItem);
        _isLoading = false;
        notifyListeners();
      });
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

}
