abstract class IHubRepository {
  Future<void> createCommunique(Object obj);
  Future<void> updateCommunique(Object obj);
  Future<void> deleteCommunique(String id);
  Future<List<Object>?> listCommuniques();
}
