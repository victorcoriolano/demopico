
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';

class GetAllCollectivesUc {
  final IColetivoRepository _repository;

  GetAllCollectivesUc() : _repository = ColetivoRepositoryImpl.instance;

  Future<List<ColetivoEntity>> execute(){
    return _repository.getAllCollectives();
  }
}