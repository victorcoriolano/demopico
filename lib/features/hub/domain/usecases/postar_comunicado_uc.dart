import 'package:demopico/features/hub/infra/interfaces/i_hub_repository.dart';
import 'package:demopico/features/hub/infra/repository/hub_repository.dart';

class PostarComunicado {

   PostarComunicado? _postarComunicado;

  PostarComunicado get getInstance{
    _postarComunicado ??= PostarComunicado(iHubRepository: HubRepository.getInstance);
    return _postarComunicado!;
  }

  IHubRepository iHubRepository;
  PostarComunicado({required this.iHubRepository});

  Future<void> postar(text, type) async {
    if (text.isEmpty || type.isEmpty) {
      throw Exception('Texto e tipo são obrigatórios') as FormatException;
    }
    await iHubRepository.postHubCommuniqueToFirebase(text, type);
  }
}
