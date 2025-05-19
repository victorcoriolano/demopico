import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/infra/services/hub_service.dart';

class ListarComunicado {
  HubService hubService;
  ListarComunicado({required this.hubService});

  Future<List<Communique>> listar() async {
    var dados = await hubService.getInstance.getAllCommuniques();
    if (dados.isEmpty) {
      throw Exception('Não foi possível listar os comunicados');
    }
    return dados;
  }
}
