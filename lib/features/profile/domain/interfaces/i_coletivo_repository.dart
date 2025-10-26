import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';

abstract interface class IColetivoRepository {
  Future<ColetivoEntity> getColetivoByID(String idColetivo);
  Future<ColetivoEntity> createColetivo(ColetivoEntity coletivo);
  Future<void> updateColetivo(ColetivoEntity coletivo);
  Future<void> addUserOnCollective(UserIdentification user);
  Future<void> removeUser(UserIdentification user);
  Future<void> sendInviteUsers(List<UserIdentification> user);
} 