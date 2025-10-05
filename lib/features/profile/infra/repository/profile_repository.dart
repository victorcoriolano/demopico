
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_data_source.dart';
import 'package:demopico/features/profile/domain/models/profile_result.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_profile_datasource.dart';
import 'package:flutter/foundation.dart';


class ProfileRepositoryImpl implements IProfileRepository {

  final IProfileDataSource profileDatasource;

  ProfileRepositoryImpl({required this.profileDatasource});

  static ProfileRepositoryImpl? _instance;
  static ProfileRepositoryImpl get getInstance {
    _instance ??= ProfileRepositoryImpl(
      profileDatasource: FirebaseProfileDatasource.getInstance
    );
    return _instance!;
  }
  final _mapper = FirebaseDtoMapper<Profile>(
    fromJson: (data, id) => ProfileFactory.fromData(data, id),
    toMap: (profile) => profile.toJson(),
    getId: (profile) => profile.userID,
  );

  @override
  Future<ProfileResult> createProfile(Profile profile) async {
    try{
      final dto = _mapper.toDTO(profile);
      final createdDto = await profileDatasource.createProfile(dto);
      return ProfileResult.success(profile: _mapper.toModel(createdDto));
    } on Failure catch (failure){
      return ProfileResult.failure(failure);
    }
  }

  @override
  Future<void> deleteProfile(String idUser) async {
      await profileDatasource.deleteProfile(idUser);
  }

  @override
  Future<ProfileResult> getProfileByUser(String id) async {
    try {
      final dto = await profileDatasource.getProfileByUser(id);
      debugPrint("Profile encontrado: $dto");
      return ProfileResult.success(profile: _mapper.toModel(dto));
    } on Failure catch (failure) {
      debugPrint("Erro ao buscar perfil do usuário: $failure");
      return ProfileResult.failure(failure);
    } catch (e){
      debugPrint("Erro desconhecido ao buscar o perfil do user: $e");
      return ProfileResult.failure(UnknownFailure(unknownError: e));
    }
  }

  @override
  Future<ProfileResult> updateProfile(Profile profile) async {
    try {
      final dto = _mapper.toDTO(profile);
      final updatedDto = await profileDatasource.updateProfile(dto);
      return ProfileResult.success(profile: _mapper.toModel(updatedDto));
    } on Failure catch (failure) {
      return ProfileResult.failure(failure);
    }
  }
}