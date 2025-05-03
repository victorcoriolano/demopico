import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_filter_spot_.dart';

class  FilterSpotUc {
  final IFilterSpot filterInterface;
  FilterSpotUc(this.filterInterface);

  /// tipos possiveis de filtros\;
  /// - tipo de local {skatepark, street, half, bowl, etc}
  /// - utilidades {agua, teto, banheiro suave arcadiar, gratuito}
  /// - modalidade {skate, parkuor, bmx }
  /// - atributos {chão, iluminação, policiamento etc}
  

  Future<List<Pico>?> filtrarPorTipoDeLocal(String tipo) async {
    try{
      final spots = await filterInterface.getSpotsByType(tipo);
      return spots;
    }catch (e){
      print("Erro ao filtrar por tipo: $e");
      return [];
    }
  }

  Future<List<Pico>?> filtrarPorUtilidade(List<String> utilidades) async {
    try{
      final spots = await filterInterface.getSpotsByUtility(utilidades);
      return spots;
    }catch (e){
      print("Erro ao filtrar por utilidade: $e");
      return [];
    }
  }

  Future<List<Pico>?> filtrarPorModalidade(String modalidade) async {
    try{
      final spots = await filterInterface.getSpotsByModality(modalidade);
      return spots;
    }catch (e){
      print("Erro ao filtrar por modalidade: $e");
      return [];
    }
  }

  Future<List<Pico>?> filtrarPorAtributo(List<String> atributos) async {
    try{
      final spots = await filterInterface.getSpotsByAttribute(atributos);
      return spots;
    }catch (e){
      print("Erro ao filtrar por atributo: $e");
      return [];
    }
  }

}