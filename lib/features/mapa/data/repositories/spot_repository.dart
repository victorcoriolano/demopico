import 'package:demopico/features/mapa/data/data_sources/interfaces/spot_datasource_interface.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
class SpotRepository implements ISpotRepository{

  final SpotRemoteDataSource dataSource;
  SpotRepository(this.dataSource);

  

  @override
  Future<PicoModel> createSpot(PicoModel pico) async {
    final data = await dataSource.create(pico.toJson());
    
    return data;

  }

  @override
  Future<void> deleteSpot(String id) async{
    await dataSource.delete(id);
  }

  @override
  Future<PicoModel> getPicoByID(String id) async {
    var pico = await  dataSource.getbyID(id);
    return pico;
  }

  @override
  Stream<List<PicoModel>> loadSpots([Filters? filtro]) {
    throw UnimplementedError();
  }

  @override
  Future<PicoModel> updateSpot(PicoModel pico) {
    throw UnimplementedError();
  }
  
  
  
}