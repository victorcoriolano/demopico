import 'package:demopico/core/domain/interfaces/register_params.dart';
import 'package:demopico/core/errors/failure_server.dart';
import 'package:demopico/features/login/domain/entities/user.dart';
import 'package:demopico/features/login/domain/interfaces/model_use_case.dart';
import 'package:demopico/features/login/domain/interfaces/auth_interface.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements UseCase<User, RegisterParams> {
  final AuthInterface authInterface;
  RegisterUseCase(this.authInterface);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return authInterface.login(params.email, params.password);
  }
}
