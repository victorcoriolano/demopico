import 'dart:async';

import 'package:demopico/features/mapa/data/data_sources/interfaces/spot_datasource_interface.dart';
import 'package:demopico/features/mapa/data/mappers/mapper_dto_picomodel.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

class SpotRepositoryImpl implements ISpotRepository{

  final SpotRemoteDataSource dataSource;
  SpotRepositoryImpl(this.dataSource);

  

  @override
  Future<PicoModel> createSpot(PicoModel pico) async {
    final newDto = await dataSource.create(MapperDtoPicomodel.toDto(pico));
    
    return MapperDtoPicomodel.fromDto(newDto);

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
        return data.map((pico) {
          return MapperDtoPicomodel.fromDto(pico);
        }).toList();
      });

    
    }
    
    @override
    Future<PicoModel> updateSpot(PicoModel pico) {
      throw UnimplementedError();
    }
    
  }


  
  
  
