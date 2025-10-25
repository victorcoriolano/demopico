

import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/user/domain/aplication/validate_credentials.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_credentials.dart';
class MockRepositoryDataUser extends Mock implements UserDataRepositoryImpl {} 

void main(){
  group("Testes de validação de credenciais", () {
    late MockRepositoryDataUser mockRepositoryDataUser;
    late ValidateUserCredentials classToTest;

    setUpAll((){
      mockRepositoryDataUser = MockRepositoryDataUser();
      classToTest = ValidateUserCredentials(repository: mockRepositoryDataUser);
    });

    setUp(() {
      reset(mockRepositoryDataUser);
    });

    test("Deve validar as credenciais do user para cadastro em caso de sucesso", () async {
      
      when(() => mockRepositoryDataUser.validateExistData(data: normalUserCredentialsSignUp.email.value, field: "email")).thenAnswer((_) => Future.value(false));
      when(() => mockRepositoryDataUser.validateExistData(data: normalUserCredentialsSignUp.vulgo.value, field: "name")).thenAnswer((_) => Future.value(false));
      final validCredentials = await classToTest.validateForSignUp(normalUserCredentialsSignUp);
      expect(validCredentials, isA<NormalUserCredentialsSignUp>());
      verify(() => mockRepositoryDataUser.validateExistData(data: normalUserCredentialsSignUp.email.value, field: "email"),).called(1);
      verify(() => mockRepositoryDataUser.validateExistData(data: normalUserCredentialsSignUp.vulgo.value, field: "name"),).called(1);
    });

    test("Deve lançar EmailAlreadyInUseFailure quando o email já existe no cadastro", () async {
      when(() => mockRepositoryDataUser.validateExistData(data: normalUserCredentialsSignUp.email.value, field: "email"))
          .thenAnswer((_) async => Future.value(true)); 
      when(() => mockRepositoryDataUser.validateExistData(data: normalUserCredentialsSignUp.vulgo.value, field: "name"))
          .thenAnswer((_) async => Future.value(false)); 

      // Espera que uma exceção EmailAlreadyInUseFailure seja lançada
      expect(
        () => classToTest.validateForSignUp(normalUserCredentialsSignUp),
        throwsA(isA<EmailAlreadyInUseFailure>()),
      );
    });

  test("Deve lançar VulgoAlreadyExistsFailure quando o vulgo já existe no cadastro", () async {
      // Configura o stub: email não existe (true), nome já existe (false)
      when(() => mockRepositoryDataUser.validateExistData(data: normalUserCredentialsSignUp.email.value, field: "email"))
          .thenAnswer((_) async => Future.value(false)); // Email NÃO existe
      when(() => mockRepositoryDataUser.validateExistData(data: normalUserCredentialsSignUp.vulgo.value, field: "name"))
          .thenAnswer((_) async => Future.value(true)); // Nome (vulgo) JÁ EXISTE

      // Espera que uma exceção VulgoAlreadyExistsFailure seja lançada
      expect( 
        () => classToTest.validateForSignUp(normalUserCredentialsSignUp),
        throwsA(isA<VulgoAlreadyExistsFailure>()),
      );

    });

    test("Deve lançar UnknownFailure para erro inesperado durante o cadastro", () async {
      // Configura o stub para lançar uma exceção genérica no primeiro método chamado
      when(() => mockRepositoryDataUser.validateExistData(data: any(named: 'data'), field: any(named: 'field')))
          .thenThrow(Exception("Erro inesperado ao cadastrar"));

      // Espera que uma UnknownFailure seja lançada encapsulando o erro original
      expect(
        () => classToTest.validateForSignUp(normalUserCredentialsSignUp),
        throwsA(isA<UnknownFailure>()),
      );

      // Verifica se pelo menos uma chamada ao repositório ocorreu
      verify(() => mockRepositoryDataUser.validateExistData(data: any(named: 'data'), field: any(named: 'field'))).called(greaterThanOrEqualTo(1));
    });

    //////////////////         TESTES DE LOGIN                   ///////////////////////////////

    test("Deve lançar InvalidCredentialsFailure para login com email quando a validação falha", () async {

      when(() => mockRepositoryDataUser.validateExistData(data: userCredentialsSignInEmail.identifier.value, field: "email"))
          .thenAnswer((_) => Future.value(false));

      expect(
        () => classToTest.validateEmailExist(userCredentialsSignInEmail),
        throwsA(isA<InvalidCredentialsFailure>()),
      );

      verify(() => mockRepositoryDataUser.validateExistData(data: userCredentialsSignInEmail.identifier.value, field: "email")).called(1);
    });

    test("Deve validar as credenciais do user COM SUCESSO quando passado email", () async {
      when(() => mockRepositoryDataUser.validateExistData(data: userCredentialsSignInEmail.identifier.value, field: "email")).thenAnswer((_) => Future.value(true));
      final validCredentials = await classToTest.validateEmailExist(userCredentialsSignInEmail);
      expect(validCredentials, isA<EmailCredentialsSignIn>());
      verify(() => mockRepositoryDataUser.validateExistData(data: userCredentialsSignInEmail.identifier.value, field: "email"),).called(1);
    });

    test("Deve validar as credenciais do user COM SUCESSO quando passado vulgo", () async {
      when(() => mockRepositoryDataUser.validateExistData(data: vulgoCredentialsSignIn.vulgo.value, field: "name")).thenAnswer((_) => Future.value(true));
      final validCredentials = await classToTest.validateVulgoExist(vulgoCredentialsSignIn);
      expect(validCredentials, isA<VulgoCredentialsSignIn>());
      verify(() => mockRepositoryDataUser.validateExistData(data: vulgoCredentialsSignIn.vulgo.value, field: "name"),).called(1);
    });

     test("Deve lançar InvalidCredentialsFailure para login com vulgo quando a validação falha", () async {
      when(() => mockRepositoryDataUser.validateExistData(data: vulgoCredentialsSignIn.vulgo.value, field: "name"))
          .thenAnswer((_) => Future.value(false));

      expect(
        () => classToTest.validateVulgoExist(vulgoCredentialsSignIn),
        throwsA(isA<InvalidCredentialsFailure>()),
      );

      verify(() => mockRepositoryDataUser.validateExistData(data: vulgoCredentialsSignIn.vulgo.value, field: "name")).called(1);
    });
  });
}

