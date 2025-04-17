import 'package:demopico/features/hub/domain/entities/communique.dart';

abstract class IHubRepository {
  Future<void> createCommunique(Communique communique);
  Future<void> updateCommunique(Communique communique);
  Future<void> deleteCommunique(String id);
  Future<List<Communique?>> listCommuniques();
}
