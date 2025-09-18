import 'package:demopico/core/common/auth/domain/entities/profile_result.dart';
import 'package:demopico/core/common/auth/domain/entities/profile_user.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_profile_repository.dart';

class UpdateProfile {
  final IProfileRepository _profileRepository;

  UpdateProfile({required IProfileRepository userDataRepository})
      : _profileRepository = userDataRepository;

  Future<ProfileResult> updateProfile(Profile profileUpdated) async {
    return  await _profileRepository.updateProfile(profileUpdated);
  }
}