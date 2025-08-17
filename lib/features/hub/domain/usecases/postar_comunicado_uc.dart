import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/interfaces/i_communique_repository.dart';
import 'package:demopico/features/hub/infra/repository/communique_repository.dart';

class PostarComunicado {

  static PostarComunicado? _postarComunicado;

 static PostarComunicado get getInstance{
    _postarComunicado ??= PostarComunicado(iHubRepository: CommuniqueRepository.getInstance);
    return _postarComunicado!;
  }

  ICommuniqueRepository iHubRepository;
  PostarComunicado({required this.iHubRepository});

  Future<void> postar(Communique communique) async {

    await iHubRepository.postHubCommuniqueToDataSource(communique);
  }
}
