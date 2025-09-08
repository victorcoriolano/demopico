import 'package:demopico/features/hub/domain/entities/communique.dart';
abstract class ICommuniqueRepository {
  Future<Communique> postHubCommuniqueToDataSource(Communique communique);
  Stream<List<Communique>> watchCommuniques();
  Future<List<Communique>> get recentCommunique;
  Future<void> updateCommunique(Communique communique);
  Future<void> deleteCommunique(String communiqueId);
}
