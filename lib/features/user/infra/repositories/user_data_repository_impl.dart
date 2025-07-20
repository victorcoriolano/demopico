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

  @override
  Future<void> addUserDetails(UserM newUser) async {
    final dto = _mapper.toDTO(newUser);
    await userFirebaseService.addUserDetails(dto);
  }


  @override
  Future<UserM> getUserDetailsByID(String uid) async {
    return _mapper.toModel(await userFirebaseService.getUserDetails(uid));
  }
  
  @override
  Future<UserM> updateUserDetails(UserM user) {
    // TODO: implement updateUserDetails
    throw UnimplementedError();
  }
  
  @override
  Future<String> getEmailByVulgo(String value) async {
    final data = await userFirebaseService.getUserByField("vulgo", value);
    final model = _mapper.toModel(data);
    return model.email;
  }
  
  @override
  Future<bool> validateDataUserAfter({required  String data, required  String field}) =>
    userFirebaseService.validateDataAfter(field, data);
  
  @override
  Future<bool> validateDataUserBefore({required String data, required String field}) =>
    userFirebaseService.validateDataAfter(field, data);

}
