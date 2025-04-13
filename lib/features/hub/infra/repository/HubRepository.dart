import 'package:demopico/features/hub/infra/interfaces/IHubRepository.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';

class HubRepository implements IHubRepository{
  @override
  Future<void> createCommunique(Communique communique) {
    // TODO: implement createCommunique
    throw UnimplementedError();
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
  Future<Communique?> readCommunique(String id) {
    // TODO: implement readCommunique
    throw UnimplementedError();
  }

  @override
  Future<void> updateCommunique(Communique communique) {
    // TODO: implement updateCommunique
    throw UnimplementedError();
  }

}