abstract class ICrudDataSource<DTO, DataSource> {
  DataSource get dataSource;

  //create
  Future<DTO> create(DTO dto);
  Future<DTO> setData(String id, DTO data);

  //read
  Future<DTO> read(String id);
  Future<List<DTO>> readAll();
  Future<List<DTO>> readAllWithFilter(String field, String value);
  Future<List<DTO>> readWithTwoFilters(
      {required String field1,
      required String value1,
      required String field2,
      required String value2});
  Future<List<DTO>> readByMultipleIDs(List<String> ids);
  //update
  Future<DTO> update(DTO dto);

  //watch
  Stream<List<DTO>> watch();
  Stream<DTO> watchDoc(String id);
  Stream<List<DTO>> watchWithFilter(String field, String value);

  //delete
  Future<void> delete(String id);

  //exists
  Future<bool> existsDataById(String id);
  Future<bool> existsDataWithField(String field, String value);
}
