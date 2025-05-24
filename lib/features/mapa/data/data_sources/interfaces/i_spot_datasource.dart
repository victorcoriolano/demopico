
import 'package:demopico/features/mapa/data/dtos/spot_firebase_dto.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';

abstract class ISpotRemoteDataSource {
  Future<SpotFirebaseDTO> create(SpotFirebaseDTO data);
  Future<void> update(SpotFirebaseDTO data);
  Stream<List<SpotFirebaseDTO>> load([Filters? filtro]);
  Future<SpotFirebaseDTO> getbyID(String id);
  Future<void> delete(String id);
}