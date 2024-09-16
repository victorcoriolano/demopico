import 'package:dartz/dartz.dart';
import 'package:demopico/core/errors/failure_server.dart';
import 'package:demopico/features/user/data/repositories/login_params.dart';
import 'package:demopico/features/user/domain/entities/user.dart';
import 'package:demopico/features/user/domain/interfaces/model_use_case.dart';
import 'package:demopico/features/user/domain/interfaces/auth_interface.dart';

class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthInterface authInterface;
  LoginUseCase(this.authInterface);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return authInterface.login(params.email, params.password);
  }
}
