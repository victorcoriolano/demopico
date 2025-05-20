
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

abstract class SpotRemoteDataSource {
  Future<PicoModel> create(Map<String, dynamic> data);
  Future<Map<String, dynamic>> update(Map<String, dynamic> data);
  Stream<List<Map<String, dynamic>>> load([Filters? filtro]);
  Future<PicoModel> getbyID(String id);
  Future<void> delete(String id);
}