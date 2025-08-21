import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_auth_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/foundation.dart';


class CriarContaUc {
  static CriarContaUc? _criarContaUc;
  static CriarContaUc get getInstance {
    _criarContaUc ??= CriarContaUc(
        userAuthRepositoryIMP: UserAuthRepository.getInstance,
        userDataRepository: UserDataRepositoryImpl.getInstance);
    return _criarContaUc!;
  }

  final IUserAuthRepository userAuthRepositoryIMP;
  final IUserDataRepository userDataRepository;


  CriarContaUc(
      {required this.userAuthRepositoryIMP,
      required this.userDataRepository});

  Future<UserM> criar(UserCredentialsSignUp credentials) async {
    if (credentials.password.length <= 7) throw InvalidPasswordFailure();
    if (!credentials.email.contains('@'))throw InvalidEmailFailure();
    if(credentials.nome.length <= 2) throw InvalidVulgoFailure();
      credentials.nome = credentials.nome.toLowerCase();
      credentials.email = credentials.email.toLowerCase();
    try {
      final newUser = await userAuthRepositoryIMP.signUp(credentials);
      await userDataRepository.addUserDetails(newUser);
      return newUser; // retornando user para já setar no provider de dados do user e precisar fazer outra requisição
    } on Failure catch (e) {
      debugPrint("UC - Ocorreu um erro conhecido ao CADASTRAR usuáriO: $e, ${e.code}");
      rethrow;
    }catch (e, st){
      debugPrint("UC - Erro desconhecido o criar conta: $e, $st");
      throw UnknownFailure(unknownError: e, stackTrace: st);
    }
  }
}
