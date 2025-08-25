import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_service.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_firebase_datasource.dart';

class UserDataRepositoryImpl implements IUserDataRepository {
  static UserDataRepositoryImpl? _userFirebaseRepository;

  static UserDataRepositoryImpl get getInstance {
    _userFirebaseRepository ??= UserDataRepositoryImpl(
        userFirebaseService: UserFirebaseDataSource.getInstance);
    return _userFirebaseRepository!;
  }

  UserDataRepositoryImpl({required this.userFirebaseService});

  final IUserDataSource<FirebaseDTO> userFirebaseService;

  final _mapper = FirebaseDtoMapper<UserM>(
    fromJson: (data, id) => UserM.fromJson(data, id),
    toMap: (user) => user.toJsonMap(),
    getId: (model) => model.id);

  UserM? _userLocalDetails;

  @override
  Future<void> addUserDetails(UserM newUser) async {
    _userLocalDetails = newUser;
    final dto = _mapper.toDTO(newUser);
    await userFirebaseService.addUserDetails(dto);
  }


  @override
  Future<UserM> getUserDetailsByID(String uid) async {
    if(_userLocalDetails != null) return _userLocalDetails!;
    _userLocalDetails = _mapper.toModel(await userFirebaseService.getUserDetails(uid));
    return _userLocalDetails!;
  }
  
  @override
  Future<UserM> updateUserDetails(UserM user) {
    _userLocalDetails = user;
    final dto = _mapper.toDTO(user);
    return userFirebaseService.update(dto).then((_) => user);
  }
  
  @override
  Future<String> getEmailByVulgo(String value) async {
    final data = await userFirebaseService.getUserByField("name", value);
    final model = _mapper.toModel(data);
    return model.email;
  }
  
  @override
  Future<bool> validateExist({required  String data, required  String field}) async =>
    await userFirebaseService.validateExistsData(field, data);
    
  @override
  UserM? get localUser => _userLocalDetails;
  
  @override
  Future<List<UserM>> getSuggestions(List<String> arguments) {
    return userFirebaseService.getSuggestions(arguments)
      .then((dtos) => dtos.map((dto) => _mapper.toModel(dto)).toList());
  }
  
  @override
  Stream<List<UserM>> searchUsers(String query) {
    return userFirebaseService.searchUsers(query)
      .map((dtos) => dtos.map((dto) => _mapper.toModel(dto)).toList());
  }
  
  @override
  Future<List<UserM>> getUsersExcept(String uid) {
    return userFirebaseService.getUsersExcept(uid)
      .then((dtos) => dtos.map((dto) => _mapper.toModel(dto)).toList());
  }
  

}
