import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/material.dart';

class CreateSpotUc {
  static CreateSpotUc? _createSpotUc;
  static CreateSpotUc get getInstance {
    _createSpotUc ??=
        CreateSpotUc(spotRepositoryIMP: SpotRepositoryImpl.getInstance, userRepository: UserDataRepositoryImpl.getInstance);
    return _createSpotUc!;
  }

  final ISpotRepository spotRepositoryIMP;
  final IUserDataRepository _userDataRepository;
  CreateSpotUc({required this.spotRepositoryIMP, required IUserDataRepository userRepository}): _userDataRepository = userRepository;

  Future<PicoModel> createSpot(PicoModel pico, [UserM? user]) async {
    try {
      final picoCriado = await spotRepositoryIMP.createSpot(pico);
      if (user != null) await _userDataRepository.updateUserDetails(user);
      return picoCriado;
      
    }on Failure catch (e) {
      debugPrint("Falha conhecida capturada: $e");
      rethrow;
    } catch (e, st) {
      throw UnknownError(message: "Erro inesperado criar piquerson: $e $st");
    }
  }
}
