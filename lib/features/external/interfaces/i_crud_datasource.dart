abstract class ICrudDataSource<DTO, DataSource> {
  DataSource get dataSource;
  
  
  //create
  Future<DTO> create(DTO dto);
  Future<DTO> setData(String id, DTO data);
  
  //read
  Future<DTO> read(String id);
  Future<List<DTO>> readAll();
  Future<List<DTO>> readAllWithFilter(String field, String value);
  Future<List<DTO>> readWithFilter(String field, String value);

  //update
  Future<DTO> update(DTO dto);

  //watch
  Stream<List<DTO>> watch(); 
  Stream<DTO> watchDoc(String id);

  //delete
  Future<void> delete(String id);  
}