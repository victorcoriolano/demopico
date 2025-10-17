
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_auth_repository.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_auth_repository.dart';

class GetCurrentUserUc   {
  final IAuthRepository _authRepository;
    static GetCurrentUserUc? _instance;
    
    static GetCurrentUserUc get instance =>
      _instance ??= GetCurrentUserUc(
        authRepository: FirebaseAuthRepository.instance
      );
  

  GetCurrentUserUc({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  UserEntity? execute() {
    return _authRepository.currentUser;
  }
}