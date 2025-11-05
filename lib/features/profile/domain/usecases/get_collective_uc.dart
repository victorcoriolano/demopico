
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';

class GetCollectiveUc {
  final IColetivoRepository _repository;

    static GetCollectiveUc? _instance;
    static GetCollectiveUc get instance =>
      _instance ??= GetCollectiveUc(repository: ColetivoRepositoryImpl.instance);
  

  GetCollectiveUc({
    required IColetivoRepository  repository
  }) : _repository = repository;

  Future<ColetivoEntity> execute(String id) async {
    return await _repository.getColetivoByID(id);
  }
}