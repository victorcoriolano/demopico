import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/repositories/favorite_spot_repository.dart';
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_favorite_spot_repository.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/presentation/dtos/spot_cart_ui_dto.dart';
import 'package:flutter/material.dart';

class FavoriteSpotUC {
  static FavoriteSpotUC? _saveSpotUc;
  static get getInstance {
    _saveSpotUc ??= FavoriteSpotUC(
        spotFavRepositoryIMP: FavoriteSpotRepository.getInstance,
        spotRepositoryIMP: SpotRepositoryImpl.getInstance);
    return _saveSpotUc!;
  }

  final IFavoriteSpotRepository spotFavRepositoryIMP;
  final ISpotRepository spotRepositoryIMP;

  FavoriteSpotUC(
      {required this.spotFavRepositoryIMP, required this.spotRepositoryIMP});

  Future<void> execute(Pico newPicoFav, String idUser) async {
    try {
      final picoFav = PicoFavorito(
        idPico: newPicoFav.id, 
        idUsuario: idUser, 
        idPicoFavorito: "",); // passando o id vazio mais sera preenchido no retorno do datasource
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
        var card = SpotCardUIDto(picoFavoritoModel: fav, pico: pico.toEntity());
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

  Future<void> removeSaveSpot(PicoFavorito pico,) async {
    try {
      await spotFavRepositoryIMP.deleteSave(pico);
    } on Failure catch (e) {
      debugPrint("Erro ao remover o pico favorito caiu no use case: $e");
      rethrow;
    }catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }
}
