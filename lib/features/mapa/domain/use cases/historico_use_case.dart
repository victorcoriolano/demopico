import 'package:demopico/features/mapa/domain/interfaces/historico_interface.dart';

class HistoricoUseCase {
  final HistoricoInterface historicoInterface;
  HistoricoUseCase(this.historicoInterface);

  Future<void> execultaSalvar(String name, double lat, double long) async {
    try{
      await historicoInterface.salvarNoHistorico(name, lat, long);
      
    }catch (e){
      print("Erro ao salvar no histórico: $e");
    }
  }

  Future<List<Map<String,dynamic>>?> execultaCarregar() async {
    try{
      final historico = await historicoInterface.carregarHistorico();
      if(historico.isEmpty){
        return [];
      }else{
        return historico;
      }
    }catch (e){
      print("Erro ao carregar historico: $e");
      return null;
    }
  }

  Future<void> execultaLimpar() async {
    try{
      await historicoInterface.limparHistorico();
    } catch (e){
      print("Erro ao limpar histórico: $e");
    }
  }

  Future<bool> execultaApagar(String nomeItem) async {
    try{
      await historicoInterface.deleteEntry(nomeItem);
      return true;
    } catch (e){
      print("Erro ao apagar item: $e");
      return false;
    }
  }
}