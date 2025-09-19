import 'package:demopico/features/profile/domain/models/profile_result.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';

abstract class IProfileRepository {
  Future<ProfileResult> createProfile(Profile profile);
  Future<ProfileResult> updateProfile(Profile profile);
  Future<ProfileResult> getProfileByUser(String id);
  Future<void> deleteProfile(String idUser);
}