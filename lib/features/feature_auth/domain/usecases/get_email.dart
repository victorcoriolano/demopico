
import 'package:barna_chat/feature_auth/domain/infra/repository_uc.dart';
import 'package:barna_chat/feature_auth/util/failure_server.dart';
import 'package:dartz/dartz.dart';

class GetIdByVulgoUseCase {
  final AuthRepository authRepository;

  GetIdByVulgoUseCase( this.authRepository);

  Future<Either<Failure, String?>> getIdByVulgo(String vulgo) async {
    return authRepository.getIdByVulgo(vulgo);
  }
}