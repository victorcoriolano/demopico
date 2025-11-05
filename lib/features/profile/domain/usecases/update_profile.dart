import 'package:demopico/features/profile/domain/models/profile_result.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';

class UpdateProfile {
  final IProfileRepository _profileRepository;

  UpdateProfile({required IProfileRepository profileDataRepo})
      : _profileRepository = profileDataRepo;

  Future<ProfileResult> execute(Profile profileUpdated) async {
    return await _profileRepository.updateProfile(profileUpdated);
  }

  Future<void> executeField(
      {required String id,
      required String field,
      required dynamic data}) async {
    return await _profileRepository.updateField(
        field: field, id: id, newData: data);
  }
}
