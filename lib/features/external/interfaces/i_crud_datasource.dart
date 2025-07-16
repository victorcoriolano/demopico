abstract class ICrudDataSource<DTO, DataSource> {
  DataSource get dataSource;
  Future<DTO> setData(String id, DTO data);
  Future<DTO> create(DTO dto);
  Future<DTO> read(String id);
  Future<DTO> update(DTO dto);
  Future<void> delete(String id);
  Future<List<DTO>> readAll();
  Stream<List<DTO>> watch(); 
  Future<List<DTO>> readAllWithFilter(String field, String value);
  Future<List<DTO>> readWithFilter(String field, String value);
}