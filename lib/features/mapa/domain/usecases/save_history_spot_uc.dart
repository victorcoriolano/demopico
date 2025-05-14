import 'package:demopico/features/mapa/domain/interfaces/i_history_repository.dart';

class SaveHistoryUc {
  final IHistoryRepository historicoInterface;
  SaveHistoryUc(this.historicoInterface);

  Future<void> execultaSalvar(String name, double lat, double long) async {
    try{
      await historicoInterface.salvarNoHistorico(name, lat, long);
      
    }catch (e){
      throw Exception("Erro ao salvar no histórico: $e");
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
      return null;
    }
  }

  Future<void> execultaLimpar() async {
    try{
      await historicoInterface.limparHistorico();
    } catch (e){
      throw Exception("Erro ao limpar o histórico: $e");
    }
  }

  Future<bool> execultaApagar(String nomeItem) async {
    try{
      await historicoInterface.deleteEntry(nomeItem);
      return true;
    } catch (e){
      return false;
    }
  }
}