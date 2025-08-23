
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:flutter/material.dart';

class DeleteSpotUC {
  final ISpotRepository spotRepository;

  DeleteSpotUC({required this.spotRepository});

  static DeleteSpotUC? _instance;

  static DeleteSpotUC get instance {
      _instance ??= DeleteSpotUC(
        spotRepository: SpotRepositoryImpl.getInstance
      );
      return _instance!;
  }
  

  

  Future<void> callDelete(String id) async {
    try {
      await spotRepository.deleteSpot(id);
    }on Failure catch (e) {
      debugPrint("Erro ao deletar: $e");
      rethrow;
    }
  }
}