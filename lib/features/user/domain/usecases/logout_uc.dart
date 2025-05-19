import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_auth_firebase_repository.dart';

class LogoutUc {
  static LogoutUc? _logoutUc;
  static LogoutUc get getInstance {
  _logoutUc ??= LogoutUc(userAuthRepository: UserAuthFirebaseRepository.getInstance);
    return _logoutUc!;
  }

  final IUserAuthRepository userAuthRepository;

  LogoutUc({required this.userAuthRepository});

  Future<void> deslogar() async {
    try {
      return await userAuthRepository.logout();
    } catch (e) {
      throw Exception("Erro ao deslogar: $e");
    }
  }
}
