
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_users_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_firebase_datasource.dart';

class UsersRepository implements IUsersRepository{
  static UsersRepository? _userFirebaseRepository;

  static UsersRepository get getInstance {
    _userFirebaseRepository ??= UsersRepository(
        userFirebaseService: UserFirebaseDataSource.getInstance);
    return _userFirebaseRepository!;
  }

  UsersRepository({required this.userFirebaseService});

  final IUserDataSource<FirebaseDTO> userFirebaseService;

  final _mapper = FirebaseDtoMapper<UserM>(
    fromJson: (data, id) => UserM.fromJson(data, id),
    toMap: (user) => user.toJsonMap(),
    getId: (model) => model.id);

   @override
  Future<List<UserM>> getSuggestionsExceptConnections(Set<String> connections) {
    return userFirebaseService.getSuggestions(connections)
      .then((dtos) => dtos.map((dto) => _mapper.toModel(dto)).toList());
  }
  
  @override
  Stream<List<UserM>> searchUsers(String query) {
    return userFirebaseService.searchUsers(query)
      .map((dtos) => dtos.map((dto) => _mapper.toModel(dto)).toList());
  }
  
  @override
  Future<List<UserM>> getSuggestionsProfileExcept(String uid) {
     return userFirebaseService.getUsersExcept(uid)
      .then((dtos) => dtos.map((dto) => _mapper.toModel(dto)).toList());
  }
  
  @override
  Future<List<UserM>> findAll() {
    return userFirebaseService.findAll()
      .then((dtos) => dtos.map((dto) => _mapper.toModel(dto)).toList());
  }
}