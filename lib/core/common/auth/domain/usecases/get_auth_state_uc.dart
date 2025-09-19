
import 'package:demopico/core/common/auth/domain/interfaces/i_auth_repository.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_auth_repository.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';

class GetAuthStateUc   {
  final IAuthRepository _authRepository;

  
    static GetAuthStateUc? _instance;
    
    static GetAuthStateUc get instance =>
      _instance ??= GetAuthStateUc(
        authRepository: FirebaseAuthRepository.instance
      );
  

  GetAuthStateUc({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  AuthState execute() {
    return _authRepository.currentAuthState;
  }
}