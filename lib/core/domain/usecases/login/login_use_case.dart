import 'package:dartz/dartz.dart';
import 'package:demopico/core/domain/entities/user.dart';
import 'package:demopico/core/errors/failure_server.dart';
import 'package:demopico/features/login/domain/interfaces/model_use_case.dart';
import 'package:demopico/features/login/domain/interfaces/repository_uc.dart';

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