import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/foundation.dart';

class ValidateUserCredentials {
  final IUserRepository repository;
  ValidateUserCredentials({required this.repository});

  static ValidateUserCredentials? _instance;
  static ValidateUserCredentials get instance => _instance ??=
      ValidateUserCredentials(repository: UserDataRepositoryImpl.getInstance);

  Future<EmailCredentialsSignIn> validateEmailExist(
      EmailCredentialsSignIn credentials) async {
    final bool exists;
    exists = await repository.validateExist(
        data: credentials.identifier.value, field: "email");
    if (exists) return credentials;
    throw InvalidCredentialsFailure();
  }

  Future<VulgoCredentialsSignIn> validateVulgoExist(
      VulgoCredentialsSignIn credentials) async {
    final bool exists;
    exists = await repository.validateExist(
        data: credentials.vulgo.value, field: "name");
    if (exists) return credentials;
    throw InvalidCredentialsFailure();
  }

  Future<NormalUserCredentialsSignUp> validateForSignUp(
      NormalUserCredentialsSignUp credentials) async {
    try {
      debugPrint("Validando email");

      final existEmail = await repository.validateExist(
        data: credentials.email.value,
        field: "email",
      );
      debugPrint("Email já existe: $existEmail");

      debugPrint("Validando vulgo");
      final existVulgo = await repository.validateExist(
        data: credentials.vulgo.value,
        field: "name",
      );
      debugPrint("Vulgo já existe: $existVulgo");

      if (existVulgo) {
        debugPrint("Lançando exception para vulgo inválido");
        throw VulgoAlreadyExistsFailure();
      }

      if (existEmail) {
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
    } catch (e, st) {
      // Tratamento genérico para outras falhas conhecidas
      debugPrint("Erro genérico ao validar credenciais: $e");
      throw UnknownFailure(unknownError: e, stackTrace: st);
    }
  }
}
