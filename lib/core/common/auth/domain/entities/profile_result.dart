import 'package:demopico/core/common/auth/domain/entities/profile_user.dart';
import 'package:demopico/core/common/errors/failure_server.dart';

class ProfileResult {
  final bool success;
  final Profile? profile;
  final Failure? failure;

  ProfileResult._({
    required this.success,
    this.profile,
    this.failure,
  });

  factory ProfileResult.success({required Profile profile}) =>
      ProfileResult._(success: true, profile: profile);

  factory ProfileResult.failure(Failure failure) =>
      ProfileResult._(success: false, failure: failure);
}