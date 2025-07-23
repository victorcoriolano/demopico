import 'package:demopico/core/common/errors/domain_failures.dart';
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
    switch (credentials.identifier){
      case (Identifiers.email):
        isValid = await repository.validateDataUserAfter(
          data: credentials.login, field: "email");

      case (Identifiers.vulgo):
        isValid = await repository.validateDataUserAfter(
          data: credentials.login, field: "name");    
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

    debugPrint("Validando email");

    final isValidEmail = await repository.validateDataUserBefore(
      data: credentials.email, 
      field: "email",
    );
    debugPrint("Email valido: $isValidEmail");

    debugPrint("Validando vulgo");
    final isValidVulgo = await  repository.validateDataUserBefore(
      data: credentials.nome, 
      field: "name",
    );
    debugPrint("Vulgo válido: $isValidVulgo");
    
    if (!isValidVulgo) {
      debugPrint("Lançando exception para vulgo inválido");
      throw VulgoAlreadyExistsFailure() ;
    }

    if (!isValidEmail) {
      debugPrint("Lançando exception para email inválido");
      throw EmailAlreadyInUseFailure();
    }
    
    debugPrint("Credenciais válidas");
    return credentials;
  } on EmailAlreadyInUseFailure catch (e) {
    debugPrint("Erro ao validar: email já está em uso - $e");
    rethrow;
  } on VulgoAlreadyExistsFailure catch (e) {
    debugPrint("Erro ao validar: vulgo já existente - $e");
    rethrow;
  } catch (e,st) {
    // Tratamento genérico para outras falhas conhecidas
    debugPrint("Erro genérico ao validar credenciais: $e");
    throw UnknownFailure(unknownError: e, stackTrace: st);
  }
}

}
