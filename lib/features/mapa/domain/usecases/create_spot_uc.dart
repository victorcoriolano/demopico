import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/material.dart';

class CreateSpotUc {
  static CreateSpotUc? _createSpotUc;
  static CreateSpotUc get getInstance {
    _createSpotUc ??=
        CreateSpotUc(spotRepositoryIMP: SpotRepositoryImpl.getInstance, userRepository: ProfileUpdateRepository.getInstance);
    return _createSpotUc!;
  }

  final ISpotRepository spotRepositoryIMP;
  final ProfileUpdateRepository _profileUpdateRepository;

  CreateSpotUc({required this.spotRepositoryIMP, required ProfileUpdateRepository userRepository}): _profileUpdateRepository = userRepository;

  Future<PicoModel> createSpot(PicoModel pico, [UserM? user]) async {
    try {
      final picoCriado = await spotRepositoryIMP.createSpot(pico);
      if (user != null) await _profileUpdateRepository.updateContributions(user);
      return picoCriado;
      
    }on Failure catch (e) {
      debugPrint("Falha conhecida capturada: $e");
      rethrow;
    } catch (e, st) {
      throw UnknownError(message: "Erro inesperado criar piquerson: $e $st");
    }
  }
}
