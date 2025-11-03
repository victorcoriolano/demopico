
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';

class RequestEntryOnCollectiveUc {
  final IColetivoRepository _repository;

  RequestEntryOnCollectiveUc()  : _repository = ColetivoRepositoryImpl.instance;

  Future<void> execute({
    required String idCollective, 
    required List<String> newEntryRequestList,
  }) async {
    final listEntry  = newEntryRequestList.toSet(); // transformando em set para remover duplicados 
    return _repository.requestEntryOnCollective(nameField: "entryRequests", idCollective: idCollective, newEntryRequestList: listEntry.toList());
  }


}