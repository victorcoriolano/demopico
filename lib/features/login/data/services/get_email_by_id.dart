

import 'package:barna_chat/feature_auth/domain/infra/repository_uc.dart';
import 'package:barna_chat/feature_auth/util/failure_server.dart';
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