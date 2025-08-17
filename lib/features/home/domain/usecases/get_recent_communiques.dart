import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/infra/repository/communique_repository.dart';

class GetRecentCommuniques {
  final CommuniqueRepository _repository;

  static GetRecentCommuniques? _instance;

  static GetRecentCommuniques get instance {
    return _instance ??=
      GetRecentCommuniques(repository: CommuniqueRepository.getInstance);
  }

  GetRecentCommuniques({
    required CommuniqueRepository repository,
  }) : _repository = repository;

  Future<List<Communique>> call() async {
    return await _repository.recentCommunique;
  }
}
