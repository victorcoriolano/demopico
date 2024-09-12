import 'package:dartz/dartz.dart';
import 'package:demopico/core/errors/failure_server.dart';
import 'package:demopico/features/login/domain/interfaces/repository_uc.dart';

class GetEmailById {
  final AuthRepository authRepository;

  GetEmailById(this.authRepository);
   Future<Either<Failure, String?>> getEmailByID(String id) async{
    return authRepository.getEmailByID(id);
   }
}