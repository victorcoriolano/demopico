import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
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

 Future<UserCredentialsSignUp> validateForSignUp(UserCredentialsSignUp credentials) async {
  try {

    
    final isValidEmail = repository.validateDataUserBefore(
      data: credentials.email, 
      field: "email",
    );

    final isValidVulgo = repository.validateDataUserBefore(
      data: credentials.nome, 
      field: "name",
    );
    

    if (isValidEmail == false) throw EmailAlreadyInUseFailure();
    if (isValidVulgo == false) throw VulgoAlreadyExistsFailure() ;

    debugPrint("Credenciais válidas");
    return credentials;
  } on EmailAlreadyInUseFailure catch (e) {
    debugPrint("Erro ao validar: email já está em uso - $e");
    rethrow;
  } on VulgoAlreadyExistsFailure catch (e) {
    debugPrint("Erro ao validar: vulgo já existente - $e");
    rethrow;
  } on Failure catch (e) {
    // Tratamento genérico para outras falhas conhecidas
    debugPrint("Erro genérico ao validar credenciais: $e");
    rethrow;
  }
}

}
