
import 'package:barna_chat/feature_auth/domain/entities/user.dart';
import 'package:barna_chat/feature_auth/domain/infra/repository_uc.dart';
import 'package:barna_chat/feature_auth/util/failure_server.dart';
import 'package:barna_chat/feature_auth/util/model_use_case.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements UseCase<User, LoginParams>{
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return authRepository.login(params.email, params.password);
  }

}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}