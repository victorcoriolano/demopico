abstract class IHubDao{
  Future<bool> create(Object obj);
  Future<Object?> getObjById(String id);
  Future<List<Object>> getAllObj();
  Future<bool> updateObj(Object obj);
  Future<bool> deleteObj(String id);
}