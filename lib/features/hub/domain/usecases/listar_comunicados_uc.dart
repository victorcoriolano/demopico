import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/infra/services/hub_service.dart';

class ListarComunicado{
  HubService hubService;
  ListarComunicado({required this.hubService});

  Future<List<Communique?>> listar() async{
   return await hubService.getInstance.getAllCommuniques();
  }
}