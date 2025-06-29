abstract class ICrudDataSource<T> {
  Future<T> create(T dto);
  Future<T> read(String id);
  Future<T> update(T dto);
  Future<void> delete(String id);
  Future<List<T>> readAll();
  Stream<List<T>> watch(); 
}