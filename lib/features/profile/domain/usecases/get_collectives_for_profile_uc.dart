
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';

class GetCollectivesForProfileUc {
  final IColetivoRepository _coletivoRepository;

    static GetCollectivesForProfileUc? _instance;
    static GetCollectivesForProfileUc get instance =>
      _instance ??= GetCollectivesForProfileUc(repository: ColetivoRepositoryImpl.instance);
  

  GetCollectivesForProfileUc({ required IColetivoRepository repository}): _coletivoRepository = repository;

  Future<List<ColetivoEntity>> execute(String profileID) async {
    return await _coletivoRepository.getCollectiveForProfile(profileID);
  }
}