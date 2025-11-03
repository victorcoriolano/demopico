import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';

abstract interface class IColetivoRepository {
  Future<ColetivoEntity> getColetivoByID(String idColetivo);
  Future<ColetivoEntity> createColetivo(ColetivoEntity coletivo);
  Future<List<ColetivoEntity>> getCollectiveForProfile(String idProfile);
  Future<List<ColetivoEntity>> getAllCollectives();
  Future<void> updateColetivo(ColetivoEntity coletivo);
  Future<void> requestEntryOnCollective({required String nameField, required String idCollective, required List<String> newEntryRequestList});
 } 