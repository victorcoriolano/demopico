import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/auth/infra/mapper/user_mapper.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';
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
  final IUserRepository _userDataRepository;
  CreateSpotUc({required this.spotRepositoryIMP, required IUserRepository userRepository}): _userDataRepository = userRepository;

  Future<PicoModel> createSpot(PicoModel pico, [UserEntity? user]) async {
    try {
      final picoCriado = await spotRepositoryIMP.createSpot(pico);
      if (user != null) await _userDataRepository.update(UserMapper.fromEntity(user));
      return picoCriado;
      
    }on Failure catch (e) {
      debugPrint("Falha conhecida capturada: $e");
      rethrow;
    } catch (e, st) {
      throw UnknownError(message: "Erro inesperado criar piquerson: $e $st");
    }
  }
}
