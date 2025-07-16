import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_service.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_firebase_service.dart';

class UserRepositoryImpl implements IUserDatabaseRepository {
  static UserRepositoryImpl? _userFirebaseRepository;

  static UserRepositoryImpl get getInstance {
    _userFirebaseRepository ??= UserRepositoryImpl(
        userFirebaseService: UserFirebaseDataSource.getInstance);
    return _userFirebaseRepository!;
  }

  UserRepositoryImpl({required this.userFirebaseService});

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
  Future<String> getEmailByUserID(String uid) async {
    return await userFirebaseService.getUserData(uid, "email");
  }

  @override
  Future<UserM> getUserDetails(String uid) async {
    return _mapper.toModel(await userFirebaseService.getUserDetails(uid));
  }

  @override
  Future<String> getUserIDByVulgo(String vulgo) async {
    final user = await userFirebaseService.getUserByField("vulgo", vulgo);
    return user.id;
  }
  
  @override
  Future<String> getEmailByVulgo(String vulgo) async {
   final dto = await userFirebaseService.getUserByField("vulgo", vulgo);
   return dto.data["email"];
}
}
