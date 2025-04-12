import 'package:demopico/features/hub/domain/entities/communique.dart';

abstract class IHubDao{
  Future<void> insertCommunique(Communique communique);
  Future<Communique?> getCommuniqueById(String id);
  Future<List<Communique>> getAllCommuniques();
  Future<void> updateCommunique(Communique communique);
  Future<void> deleteCommunique(String id);
}