
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';
import 'package:demopico/features/profile/infra/repository/profile_repository.dart';
import 'package:flutter/widgets.dart';

class CreateCollectiveUc {
  final IColetivoRepository _repository;
  final IProfileRepository _profileRepository;

  static CreateCollectiveUc? _instance;
  static CreateCollectiveUc get instance =>
      _instance ??= CreateCollectiveUc(repository: ColetivoRepositoryImpl.instance, profRepo: ProfileRepositoryImpl.getInstance);
  

  CreateCollectiveUc({required IColetivoRepository repository, required IProfileRepository profRepo}): _repository = repository, _profileRepository = profRepo;

  Future<ColetivoEntity> execute(ColetivoEntity coletivo, List<String> idcoletivos) async {
    debugPrint("Lista de idcoletivos do user atual: $idcoletivos - ${idcoletivos.length}");
    final newColetivo = await _repository.createColetivo(coletivo);
    idcoletivos.add(newColetivo.id);
    debugPrint("Lista de coletivos do user atual: $idcoletivos");
    await _profileRepository.updateField(id: coletivo.modarator.id, field: "idColetivos", newData: idcoletivos);
    if (coletivo.guests.isNotEmpty) await _repository.sendInviteUsers(coletivo.guests);
    return newColetivo;
  }
}