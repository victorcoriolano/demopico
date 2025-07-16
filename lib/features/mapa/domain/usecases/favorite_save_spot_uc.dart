import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/repositories/favorite_spot_repository.dart';
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_favorite_spot_repository.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/presentation/dtos/spot_cart_ui_dto.dart';
import 'package:flutter/material.dart';

class SaveSpotUc {
  static SaveSpotUc? _saveSpotUc;
  static get getInstance {
    _saveSpotUc ??= SaveSpotUc(
        spotFavRepositoryIMP: FavoriteSpotRepository.getInstance,
        spotRepositoryIMP: SpotRepositoryImpl.getInstance);
    return _saveSpotUc!;
  }

  final IFavoriteSpotRepository spotFavRepositoryIMP;
  final ISpotRepository spotRepositoryIMP;

  SaveSpotUc(
      {required this.spotFavRepositoryIMP, required this.spotRepositoryIMP});

  Future<void> saveSpot(PicoFavorito picoFav) async {
    try {
      await spotFavRepositoryIMP.saveSpot(picoFav);

    } on Failure catch (e) {
      debugPrint("Erro ao salvar o pico favorito caiu no use case: $e");
      rethrow;
    }catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }

  Future<List<SpotCardUIDto>> listFavoriteSpot(String idUser) async {
    try{
      final favoritos = await spotFavRepositoryIMP.listFavoriteSpot(idUser);
      debugPrint("Picos favoritos vindo do firebase: ${favoritos.length}");
      final result = await Future.wait(favoritos.map((fav) async {
        final pico = await spotRepositoryIMP.getPicoByID(fav.idPico); // retorna PicoModel
        var card = SpotCardUIDto(picoFavoritoModel: fav, picoModel: pico);
        debugPrint("Pico: ${pico.picoName}");
        debugPrint("Pico card: ${card.toString()}");
        return card;
      }));

      debugPrint("Picos resultados : ${result.length}");
      return result;
    
    } on Failure catch (e) {
      debugPrint("Erro ao buscar os picos salvos: $e");
      rethrow;
    }
      
  }

  Future<void> removeSaveSpot(String idPicoFavModel) async {
    try {
      await spotFavRepositoryIMP.deleteSave(idPicoFavModel);
    } on Failure catch (e) {
      debugPrint("Erro ao remover o pico favorito caiu no use case: $e");
      rethrow;
    }catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }
}
