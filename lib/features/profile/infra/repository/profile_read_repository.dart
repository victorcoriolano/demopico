import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_read_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/foundation.dart';

class ProfileReadRepository implements IProfileReadRepository {
  static ProfileReadRepository? _profileReadRepository;

  static ProfileReadRepository get getInstance {
    _profileReadRepository ??= ProfileReadRepository(
        userRepositoryIMP: UserDataRepositoryImpl.getInstance);
    return _profileReadRepository!;
  }

  ProfileReadRepository({required this.userRepositoryIMP});

  final IUserDataRepository userRepositoryIMP;

  @override
  Future<String> getBio(UserM userModel) async {
    try{
      String uid = userModel.id;
      UserM user = await userRepositoryIMP.getUserDetailsByID(uid);
      return user.description!;
    }on Failure catch (e) {
      debugPrint("PROFILLE-REPO: ERRO CONHECIDO - $e");
      rethrow;
    }catch (e){
      throw UnknownFailure(unknownError: e);
    } 

  }

  @override
  Future<int> getContributions(UserM userModel) async {
    try {
      String uid = userModel.id;
      UserM user = await userRepositoryIMP.getUserDetailsByID(uid);
      return user.picosAdicionados;
    } on Failure catch (e) {
      debugPrint("PROFILLE-REPO: ERRO CONHECIDO - $e");
      rethrow;
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }

  @override
  Future<String> getPhoto(UserM userModel) async {
    try {
      String uid = userModel.id;
      UserM user = await userRepositoryIMP.getUserDetailsByID(uid);
      return user.pictureUrl!;
    } on Failure catch (e) {
      debugPrint("PROFILLE-REPO: ERRO CONHECIDO - $e");
      rethrow;
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }

  @override
  Future<int> getFollowers(UserM userModel) async {
    try {
      String uid = userModel.id;
      UserM user = await userRepositoryIMP.getUserDetailsByID(uid);
      return user.conexoes;
    } on Failure catch (e) {
      debugPrint("PROFILLE-REPO: ERRO CONHECIDO - $e");
      rethrow;
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }
}
