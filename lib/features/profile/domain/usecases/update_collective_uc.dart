import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';
import 'package:flutter/foundation.dart';

class UpdateCollectiveUc {
  final IColetivoRepository _coletivoRepository;

  UpdateCollectiveUc() : _coletivoRepository = ColetivoRepositoryImpl.instance;

  Future<void> execute(ColetivoEntity coletivo) async {
    try {
      return await _coletivoRepository.updateColetivo(coletivo);
    } on Failure catch (e) {
      debugPrint("ERRO NO USE CASE: $e");
      rethrow;
    }
  }
}