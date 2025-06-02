
import 'package:demopico/features/mapa/data/dtos/pico_model_firebase_dto.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';

abstract class SpotRemoteDataSource {
  Future<PicoFirebaseDTO> create(PicoFirebaseDTO data);
  Future<void> update(PicoFirebaseDTO data);
  Stream<List<PicoFirebaseDTO>> load([Filters? filtro]);
  Future<PicoFirebaseDTO> getbyID(String id);
  Future<void> delete(String id);
}