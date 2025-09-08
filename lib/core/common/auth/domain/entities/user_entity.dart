
import 'package:demopico/core/common/auth/domain/entities/profile_user.dart';
import 'package:demopico/core/common/auth/domain/value_objects/dob_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';

sealed class TypeUser {}

class UserEntity extends TypeUser {
  final String id;
  final String displayName;
  final EmailVO email;
  final DobVo dob;
  final LocationVo location;
  final Profile profileUser;

  UserEntity({
      required this.displayName,
    required this.id,
    required this.email,
    required this.dob,
    required this.location,
    required this.profileUser,
  });  

  UserEntity copyWith({
    String? displayName,
    String? id,
    EmailVO? email,
    DobVo? dob,
    LocationVo? location,
    Profile? profileUser,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      location: location ?? this.location,
      profileUser: profileUser ?? this.profileUser,
      displayName: displayName ?? this.displayName,
    );
  }
  
}

class ColetivoEntity extends TypeUser {
  //TODO
}

class AnonymousUserEntity extends TypeUser {}

class AdminUserEntity extends TypeUser {}