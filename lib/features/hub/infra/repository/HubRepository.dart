import 'package:demopico/features/hub/infra/daos/HubFirebaseDAO.dart';
import 'package:demopico/features/hub/infra/interfaces/IHubRepository.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';

class HubRepository implements IHubRepository{
  final HubFirebaseDAO dao;

  HubRepository({required this.dao});

  @override
  Future<void> createCommunique(Communique communique) async {
    await dao.create(communique);
  }

  @override
  Future<void> deleteCommunique(String id) {
    // TODO: implement deleteCommunique
    throw UnimplementedError();
  }

  @override
  Future<List<Communique>> listCommuniques() {
    // TODO: implement listCommuniques
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateCommunique(Communique communique) {
    // TODO: implement updateCommunique
    throw UnimplementedError();
  }

}