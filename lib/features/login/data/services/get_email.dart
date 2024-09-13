
import 'package:dartz/dartz.dart';
import 'package:demopico/core/errors/failure_server.dart';
import 'package:demopico/features/login/domain/interfaces/repository_uc.dart';

class GetIdByVulgoUseCase {
  final AuthRepository authRepository;

  GetIdByVulgoUseCase( this.authRepository);

  Future<Either<Failure, String?>> getIdByVulgo(String vulgo) async {
    return authRepository.getIdByVulgo(vulgo);
  }
}