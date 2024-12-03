import 'package:demopico/features/mapa/domain/use%20cases/historico_use_case.dart';
import 'package:flutter/material.dart';

class HistoricoController extends ChangeNotifier {
  final HistoricoUseCase useCase;

  List<Map<String, dynamic>> _historico = [];
  List<Map<String, dynamic>> get historico => _historico;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HistoricoController(this.useCase);

  Future<void> carregarHistorico() async {
    _isLoading = true;
    notifyListeners();

    final historicoCarregado = await useCase.execultaCarregar();
    if (historicoCarregado != null) {
      _historico = historicoCarregado;
    }

    _isLoading = false;
    notifyListeners();
  }


  Future<void> salvarNoHistorico(String name, double lat, double long) async {
    _isLoading = true;
    notifyListeners();

    await useCase.execultaSalvar(name, lat, long);
    await carregarHistorico();

    _isLoading = false;
    notifyListeners();
  }


  Future<void> limparHistorico() async {
    _isLoading = true;
    notifyListeners();

    await useCase.execultaLimpar();
    _historico = []; 

    _isLoading = false;
    notifyListeners();
  }


  Future<void> apagarItem(String nomeItem) async {
    _isLoading = true;
    notifyListeners();

    final sucesso = await useCase.execultaApagar(nomeItem);
    if (sucesso) {

      _historico.removeWhere((item) => item['name'] == nomeItem);
    }

    _isLoading = false;
    notifyListeners();
  }
}
