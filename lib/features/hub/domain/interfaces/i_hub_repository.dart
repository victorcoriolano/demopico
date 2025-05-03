import 'package:demopico/features/hub/domain/entities/communique.dart';
abstract class IHubRepository {
  Future<void> postHubCommuniqueToFirebase(String text, dynamic type);
  Future<List<Communique>> getAllCommuniques();
  Future<void> updateCommunique(Communique communique);
  Future<void> deleteCommunique(String communiqueId);
}
