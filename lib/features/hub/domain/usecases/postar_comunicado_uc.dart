import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_repository.dart';
import 'package:demopico/features/hub/infra/repository/hub_repository.dart';

class PostarComunicado {

  static PostarComunicado? _postarComunicado;

 static PostarComunicado get getInstance{
    _postarComunicado ??= PostarComunicado(iHubRepository: HubRepository.getInstance);
    return _postarComunicado!;
  }

  IHubRepository iHubRepository;
  PostarComunicado({required this.iHubRepository});

  Future<Communique> postar(text, type) async {
    if (text.isEmpty || type.isEmpty) {
      throw Exception('Texto e tipo são obrigatórios') as FormatException;
    }
    return await iHubRepository.postHubCommuniqueToFirebase(text, type);
  }
}
