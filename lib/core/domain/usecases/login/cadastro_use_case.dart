import 'package:demopico/core/errors/failure_server.dart';
import 'package:demopico/features/login/domain/entities/user.dart';
import 'package:demopico/features/login/domain/interfaces/model_use_case.dart';
import 'package:demopico/features/login/domain/interfaces/repository_uc.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements UseCase<User, RegisterParams> {
  final AuthRepository authRepository;
  RegisterUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return authRepository.login(params.email, params.password);
  }
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email, required this.password});
}
