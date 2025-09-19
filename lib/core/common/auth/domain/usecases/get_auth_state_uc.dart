
import 'package:demopico/core/common/auth/domain/interfaces/i_auth_repository.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';

class GetAuthStateUc   {
  final IAuthRepository _authRepository;

  GetAuthStateUc({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  Stream<AuthState> execute() {
    return _authRepository.authState;
  }
}