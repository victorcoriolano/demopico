import 'package:demopico/features/profile/domain/models/profile_result.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';

class UpdateProfile {
  final IProfileRepository _profileRepository;

  UpdateProfile({required IProfileRepository userDataRepository})
      : _profileRepository = userDataRepository;

  Future<ProfileResult> updateProfile(Profile profileUpdated) async {
    return  await _profileRepository.updateProfile(profileUpdated);
  }
}