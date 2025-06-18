import 'dart:async';

import 'package:demopico/core/common/data/interfaces/datasource/i_mapper_dto.dart';
import 'package:demopico/core/common/data/mappers/firebase_dto_mapper.dart';
import 'package:demopico/features/mapa/data/data_sources/interfaces/i_spot_datasource.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_spot_remote_datasource.dart';
import 'package:demopico/features/mapa/data/mappers/mapper_dto_picomodel.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:flutter/foundation.dart';

class SpotRepositoryImpl implements ISpotRepository {

  static SpotRepositoryImpl? _spotRepositoryImpl;
  static SpotRepositoryImpl get getInstance 
    => _spotRepositoryImpl ??= SpotRepositoryImpl(
      FirebaseSpotRemoteDataSource.getInstance
    );
    

  final ISpotRemoteDataSource dataSource;
  SpotRepositoryImpl(this.dataSource);

    final IMapperDto _mapper = FirebaseDtoMapper<PicoModel>(
    fromJson: (data, id) => PicoModel.fromJson(data, id),
    toMap: (model) => model.toMap() , 
    getId: (model) => model.id,
  );


  @override
  Future<PicoModel> createSpot(PicoModel pico) async {
    
    final picoDto = await _mapper.toModalDto(pico);
    final firebaseDto =  _mapper.toDatasourceDto(picoDto);

    return  _mapper.toModalDto(firebaseDto);

  }

  @override
  Future<void> deleteSpot(String id) async{
    await dataSource.delete(id);
  }

  @override
  Future<PicoModel> getPicoByID(String id) async {
    var data = await  dataSource.getbyID(id);
    return MapperDtoPicomodel.fromDto(data);
  }

  @override
  Stream<List<PicoModel>> loadSpots([Filters? filtros]) {    

    final dataStream = dataSource.load(filtros);

      return dataStream.map((data) {
        final picos = data.map((pico) {
          return MapperDtoPicomodel.fromDto(pico);
        }).toList();
        debugPrint("picos: $picos");
        return picos;
      });

    
  }
    
  @override
  Future<PicoModel> updateSpot(PicoModel pico) async {
    final dto = MapperDtoPicomodel.toDto( pico);
    await dataSource.update(dto);
    return  pico;
  }
}


  
  
  
