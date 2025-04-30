import 'package:demopico/features/hub/domain/entities/communique.dart';

abstract class IHubService {
  Future<void> createCommunique(Communique communique);
  Future<void> updateCommunique(Communique communique);
  Future<void> deleteCommunique(String id);
  Future<List<Communique>> listCommuniques();
}
