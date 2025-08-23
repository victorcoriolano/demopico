
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';

class GetStateUser {
  static AuthState get authState{
    final user = UserDataRepositoryImpl.getInstance.localUser;
    return AuthState.fromUserState(user);
  }
}