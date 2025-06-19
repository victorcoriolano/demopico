import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:flutter/material.dart';

class CreateSpotUc {
  static CreateSpotUc? _createSpotUc;
  static CreateSpotUc get getInstance {
    _createSpotUc ??=
        CreateSpotUc(spotRepositoryIMP: SpotRepositoryImpl.getInstance);
    return _createSpotUc!;
  }

  final ISpotRepository spotRepositoryIMP;

  CreateSpotUc({required this.spotRepositoryIMP});

  Future<PicoModel> createSpot(PicoModel pico) async {
    try {
      final picoCriado = await spotRepositoryIMP.createSpot(pico);
      return picoCriado;
      
    }on Failure catch (e) {
      debugPrint("Falha conhecida capturada: $e");
      rethrow;
    } catch (e, st) {
      throw UnknownError("Erro inesperado criar piquerson: $e $st");
    }
  }
}
