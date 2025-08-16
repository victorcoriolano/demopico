import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/interfaces/i_communique_repository.dart';
import 'package:demopico/features/hub/infra/repository/communique_repository.dart';

class ListarComunicado{
  ICommuniqueRepository hubRepositoryIMP;
  ListarComunicado({required this.hubRepositoryIMP});

    static ListarComunicado? _listarComunicado;

    static ListarComunicado get getInstance{
      _listarComunicado ??= ListarComunicado(hubRepositoryIMP: CommuniqueRepository.getInstance);
      return _listarComunicado!;
    }


  Stream<List<Communique>> listar() {
    var dados = hubRepositoryIMP.watchCommuniques();
    return dados;
  }
}
