import 'package:demopico/features/user/domain/models/user.dart';

abstract class IUsersRepository {
  Stream<List<UserM>> searchUsers(String query);
  Future<List<UserM>> findAll();  
  Future<List<UserM>> getSuggestionsProfileExcept(String uid);
  Future<List<UserM>> getSuggestionsExceptConnections(Set<String> connectionsExcept);
  Future<List<UserM>> getUsersByIds(List<String> ids);
}