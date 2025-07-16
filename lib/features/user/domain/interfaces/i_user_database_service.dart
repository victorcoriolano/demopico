
abstract class IUserDataSource<DTO>{
  Future<void> addUserDetails(DTO newUser);
  Future<DTO> getUserDetails(String uid);
  Future<String> getUserData(String id, String field);
  Future<DTO> getUserByField(String field, String value);
}