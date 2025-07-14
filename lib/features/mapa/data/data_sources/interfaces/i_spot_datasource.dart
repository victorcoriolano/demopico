
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';

abstract class ISpotRemoteDataSource {
  Future<FirebaseDTO> create(FirebaseDTO data);
  Future<void> update(FirebaseDTO data);
  Stream<List<FirebaseDTO>> load([Filters? filtro]);
  Future<FirebaseDTO> getbyID(String id);
  Future<void> delete(String id);
}