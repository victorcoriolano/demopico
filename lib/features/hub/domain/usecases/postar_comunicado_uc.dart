import 'package:demopico/features/hub/infra/services/hub_service.dart';

class PostarComunicado {
  HubService hubService;
  PostarComunicado({required this.hubService});

  Future<void> postar(text, type) async {
    if (text.isEmpty || type.isEmpty) {
      throw Exception('Texto e tipo são obrigatórios');
    }
    await hubService.postHubCommuniqueToFirebase(text, type);
  }
}
