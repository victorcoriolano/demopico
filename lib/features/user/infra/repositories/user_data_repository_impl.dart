import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_service.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_firebase_datasource.dart';

class UserDataRepositoryImpl implements IUserRepository {
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
    toMap: (user) => user.toJson(),
    getId: (model) => model.id);

  UserM? _userLocalDetails;

  @override
  Future<UserM> addUserDetails(UserM newUser) async {
    _userLocalDetails = newUser;
    final dto = _mapper.toDTO(newUser);
    await userFirebaseService.addUserDetails(dto);
    return newUser;
  }


  @override
  Future<UserM> getById(String uid) async {
    if(_userLocalDetails != null) return _userLocalDetails!;
    _userLocalDetails = _mapper.toModel(await userFirebaseService.getUserDetails(uid));
    return _userLocalDetails!;
  }
  
  @override
  Future<EmailVO> getEmailByVulgo(VulgoVo vulgo) async {
    final data = await userFirebaseService.getUserByField("name", vulgo.value);
    final model = _mapper.toModel(data);
    return EmailVO(model.email);
  }
  
  @override
  Future<bool> validateExistData({required  String data, required  String field}) async =>
    await userFirebaseService.validateExistsData(field, data);
    
  @override
  Future<void> deleteData(String uid) async {
    await userFirebaseService.delete(uid);
  }
    
  @override
  Future<UserM> update(UserM user) {
    _userLocalDetails = user;
    final dto = _mapper.toDTO(user);
    return userFirebaseService.update(dto).then((_) => user);
  }
}
