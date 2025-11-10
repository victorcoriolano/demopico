
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';

class GetCollectiveById {
  final IColetivoRepository _repository;

    static GetCollectiveById? _instance;
    static GetCollectiveById get instance =>
      _instance ??= GetCollectiveById(repository: ColetivoRepositoryImpl.instance);
  

  GetCollectiveById({
    required IColetivoRepository  repository
  }) : _repository = repository;

  Future<ColetivoEntity> execute(String id) async {
    return await _repository.getColetivoByID(id);
  }
}