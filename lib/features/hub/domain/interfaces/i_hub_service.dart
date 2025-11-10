
abstract class IHubService<DTO> {
  Future<DTO> create(DTO communique);
  Future<DTO> update(DTO communique);
  Future<void> delete(String id);
  Stream<List<DTO>> list(String docRef, String collectionPath);
}
