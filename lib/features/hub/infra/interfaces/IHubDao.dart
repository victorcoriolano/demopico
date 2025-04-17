abstract class IHubDao{
  Future<void> create(Object obj);
  Future<List<Object>> getAllObj();
  Future<void> updateObj(Object obj);
  Future<void> deleteObj(String id);
}