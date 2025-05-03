import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_repository.dart';

class ListarComunicado{
  IHubRepository iHubRepository;
  ListarComunicado({required this.iHubRepository});

  Future<List<Communique>> listar() async{
   return await iHubRepository.getAllCommuniques();
  }
}