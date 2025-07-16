
import 'package:demopico/features/mapa/domain/entities/filters.dart';

abstract class ISpotDataSource<DTO> {
  Future<DTO> create(DTO data);
  Future<void> update(DTO data);
  Stream<List<DTO>> load([Filters? filtro]);
  Future<DTO> getbyID(String id);
  Future<List<DTO>> getList(String id);
  Future<void> delete(String id);
}