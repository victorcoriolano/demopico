import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';

abstract interface class IColetivoRepository {
  Future<ColetivoEntity> getColetivoByID(String idColetivo);
  Future<ColetivoEntity> createColetivo(ColetivoEntity coletivo);
  Future<List<ColetivoEntity>> getCollectiveForProfile(String idProfile);
  Future<void> updateColetivo(ColetivoEntity coletivo);
  Future<void> addUserOnCollective(UserIdentification user);
  Future<void> removeUser(UserIdentification user);
  Future<void> sendInviteUsers(List<String> user);
} 