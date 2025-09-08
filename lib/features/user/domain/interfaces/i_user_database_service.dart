
abstract class IUserDataSource<DTO>{
  //CREATE
  Future<void> addUserDetails(DTO newUser);
  //GET
  Future<List<DTO>> findAll();
  Future<DTO> getUserDetails(String uid);
  Future<String> getUserData(String id, String field);
  Future<DTO> getUserByField(String field, String value);

  Future<List<DTO>> getSuggestions(Set<String> connectionsUserExcept);
  Future<List<DTO>> getUsersExcept(String uid);
  Future<List<DTO>> getUsersByIds(List<String> ids);
  //SEARCH
  Stream<List<DTO>> searchUsers(String query);
  //VALIDATE
  Future<bool> validateExistsData(String field, String value);
  //UPDATE
  Future<void> update(DTO user);
}