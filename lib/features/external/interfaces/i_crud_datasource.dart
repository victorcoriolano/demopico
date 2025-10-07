abstract class ICrudDataSource<DTO, DataSource> {
  DataSource get dataSource;

  //create
  Future<DTO> create(DTO dto);
  Future<DTO> setData(String id, DTO data);
  Future<DTO> createWithTwoCollections(DTO dto);
  

  //read
  Future<DTO> read(String id);
  Future<List<DTO>> readAll();
  Future<List<DTO>> readAllWithFilter(String field, String value);
  Future<List<DTO>> readWithTwoFilters(
      {required String field1,
      required String value1,
      required String field2,
      required String value2});
  Future<List<DTO>> readExcept(String field, String value);
  Future<List<DTO>> readMultiplesExcept(String field, Set<String> values);
  Future<List<DTO>> readMultiplesByIds(List<String> ids);
  //update
  Future<DTO> update(DTO dto);
  Future<void> updateField(String id, String field, dynamic value);

  //watch
  Stream<List<DTO>> watch();
  Stream<DTO> watchDoc(String id);
  Stream<List<DTO>> watchWithFilter(String field, String value);
  Stream<DTO> watchDocWithCollection(String docRef, String collectionPath, String docData);

  //delete
  Future<void> delete(String id);

  //exists
  Future<bool> existsDataById(String id);
  Future<bool> existsDataWithField(String field, String value);
}
