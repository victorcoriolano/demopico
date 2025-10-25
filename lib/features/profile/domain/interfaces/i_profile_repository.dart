import 'package:demopico/features/profile/domain/models/profile_result.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';

abstract class IProfileRepository {
  Future<ProfileResult> createProfile(Profile profile);
  Future<ProfileResult> updateProfile(Profile profile);
  Future<void> updateField({required String id, required String field,required dynamic newData});
  Future<ProfileResult> getProfileByUser(String id);
  Future<void> deleteProfile(String idUser);
}