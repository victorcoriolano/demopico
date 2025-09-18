
import 'package:demopico/core/common/auth/domain/entities/profile_result.dart';
import 'package:demopico/core/common/auth/domain/entities/profile_user.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_datasource.dart';

class FirebaseProfileDatasource implements IProfileDatasource{
  @override
  Future<ProfileResult> createProfile(Profile profile) {
    // TODO: implement createProfile
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProfile(String idUser) {
    // TODO: implement deleteProfile
    throw UnimplementedError();
  }

  @override
  Future<ProfileResult> getProfileByUser(String id) {
    // TODO: implement getProfileByUser
    throw UnimplementedError();
  }

  @override
  Future<ProfileResult> updateProfile(Profile profile) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
  
}