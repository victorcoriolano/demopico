
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/auth/infra/mapper/user_mapper.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:flutter/material.dart';

class UpdateUserEntityUc {
  final IProfileRepository _profileRepo;
  final IUserRepository _userRepo;
  
  UpdateUserEntityUc({
    required IProfileRepository repo1,
    required IUserRepository repo2,
  }): _profileRepo = repo1, _userRepo = repo2;

  Future<UserEntity> execute(UserEntity user) async {
    try {
      final newProfile = await _profileRepo.updateProfile(user.profileUser);
      await _userRepo.update(UserMapper.fromEntity(user));
      return newProfile.success
        ? user.copyWith(profileUser: newProfile.profile)
        : throw newProfile.failure!;
    }on Failure catch (e){
      debugPrint("Erro ao atualizar o perfil UC -> $e");
      rethrow;
    }
  }
}