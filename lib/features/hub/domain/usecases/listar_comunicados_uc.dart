import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_repository.dart';
import 'package:demopico/features/hub/infra/repository/hub_repository.dart';

class ListarComunicado{
  IHubRepository hubRepositoryIMP;
  ListarComunicado({required this.hubRepositoryIMP});

    static ListarComunicado? _listarComunicado;

    static ListarComunicado get getInstance{
      _listarComunicado ??= ListarComunicado(hubRepositoryIMP: HubRepository.getInstance);
      return _listarComunicado!;
    }


  Future<List<Communique>> listar() async {
    var dados = await hubRepositoryIMP.getAllCommuniques();
    if (dados.isEmpty) {
      throw Exception('Não foi possível listar os comunicados');
    }
    return dados;
  }
}
