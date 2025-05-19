import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';

class PegarDadosUserUc {
  static PegarDadosUserUc? _pegarDadosUserUc;
  static PegarDadosUserUc get getInstance {
    _pegarDadosUserUc ??= PegarDadosUserUc(
      userDatabaseRepositoryIMP: UserFirebaseRepository.getInstance,
    );
    return _pegarDadosUserUc!;
  }

  final IUserDatabaseRepository userDatabaseRepositoryIMP;

  PegarDadosUserUc({required this.userDatabaseRepositoryIMP});

  Future<UserM?> getDados(String uid) async {
     try {
      return await userDatabaseRepositoryIMP.getUserDetails(uid);
    } catch (e) {
      return null;
    }
  }
}