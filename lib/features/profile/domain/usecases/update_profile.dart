import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/models/profile_result.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/material.dart';

class UpdateProfile {
  final IProfileRepository _profileRepository;
  final IUserRepository _userRepository;

  UpdateProfile({required IProfileRepository profileDataRepo, required IUserRepository userRepo})
      : _profileRepository = profileDataRepo, _userRepository = userRepo;

    static UpdateProfile? _instance;
    
    static UpdateProfile get instance =>
      _instance ??= UpdateProfile(profileDataRepo: ProfileRepositoryImpl.getInstance, userRepo: UserDataRepositoryImpl  .getInstance);
  

  Future<ProfileResult> execute(Profile profileUpdated) async {
    try {
      final updatedProfileResult = await _profileRepository.updateProfile(profileUpdated);

      
      return updatedProfileResult;
    } on Failure catch (e) {
      debugPrint("UC Erro ao atualizar o perfil: ${e.message}");
      return ProfileResult.failure(e);
    }
  }

  Future<void> executeField(
      {required String id,
      required String field,
      required dynamic data}) async {
    return await _profileRepository.updateField(
        field: field, id: id, newData: data);
  }
}
