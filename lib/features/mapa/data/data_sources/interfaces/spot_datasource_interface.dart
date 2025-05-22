
import 'package:demopico/features/mapa/data/dtos/pico_model_firebase_dto.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';

abstract class SpotRemoteDataSource {
  Future<PicoModelFirebaseDto> create(PicoModelFirebaseDto data);
  Future<void> update(PicoModelFirebaseDto data);
  Stream<List<PicoModelFirebaseDto>> load([Filters? filtro]);
  Future<PicoModelFirebaseDto> getbyID(String id);
  Future<void> delete(String id);
}