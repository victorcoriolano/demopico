import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:demopico/features/profile/domain/models/profile_result.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/features/profile/infra/repository/profile_repository.dart';


class GetProfileUserByID {
  static GetProfileUserByID? _pegarDadosUserUc;
  static GetProfileUserByID get getInstance {
    _pegarDadosUserUc ??= GetProfileUserByID(
      profileRepository: ProfileRepositoryImpl.getInstance,
    );
    return _pegarDadosUserUc!;
  }

  final IProfileRepository _profileRepository;

  GetProfileUserByID({required IProfileRepository profileRepository})
    : _profileRepository = profileRepository;

  Future<ProfileResult> execute(String uid) async {
     return await _profileRepository.getProfileByUser(uid);
  }
}