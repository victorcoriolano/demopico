import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/enums/identifiers.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/foundation.dart';

class ValidateUserCredentials {
  final IUserDataRepository repository;
  ValidateUserCredentials({required this.repository});

  static ValidateUserCredentials? _instance;
  static ValidateUserCredentials get instance => _instance ??=
      ValidateUserCredentials(repository: UserDataRepositoryImpl.getInstance);

  Future<UserCredentialsSignIn> validateForLogin(
      UserCredentialsSignIn credentials) async {
    
    bool isValid = false;
    if (credentials.identifier == Identifiers.vulgo) {
      isValid = await repository.validateDataUserAfter(
          data: credentials.login, field: "name");
    } else {
      isValid = await repository.validateDataUserAfter(
          data: credentials.login, field: "email");
    }

    if (isValid) {
      debugPrint("Credenciais válidas");
      return credentials;
    } else {
      debugPrint("Credenciais inválidas");
      throw InvalidCredentialsFailure();
    }
  }
}
