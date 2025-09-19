import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/core/common/auth/domain/value_objects/dob_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';

class UserEntity {
  final String id;
  final VulgoVo displayName;
  final EmailVO email;
  final DobVo dob;
  final LocationVo? location;
  final Profile profileUser;
  final String? avatar;

  UserEntity({
    required this.id,
    required this.displayName,
    required this.email,
    required this.dob,
    required this.location,
    required this.profileUser,
    required this.avatar,
  });

  UserEntity copyWith({
    String? avatar,
    VulgoVo? displayName,
    String? id,
    EmailVO? email,
    DobVo? dob,
    LocationVo? location,
    Profile? profileUser,
  }) {
    return UserEntity(
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      location: location ?? this.location,
      profileUser: profileUser ?? this.profileUser,
      displayName: displayName ?? this.displayName,
    );
  }

  factory UserEntity.initial(String id, VulgoVo displayName, EmailVO email, LocationVo? location, String? avatar){
    return UserEntity(
      id: id, 
      avatar: avatar,
      displayName: displayName, 
      email: email, 
      dob: DobVo(DateTime.now()), 
      location: location, 
      profileUser: ProfileFactory.initialFromUser(id, displayName.value, avatar));
    
  }
}

class ColetivoEntity {
  final String id;
  final String uid;
  final List<String> members;
  final String logo;
  const ColetivoEntity(
      {required this.id,
      required this.uid,
      required this.members,
      required this.logo});
}

class AnonymousUserEntity extends UserEntity {
  AnonymousUserEntity()
      : super(
            avatar: "",
            id: "",
            location: LocationVo.empty(),
            displayName: VulgoVo.empty(),
            dob: DobVo(DateTime.now()),
            email: EmailVO.empty(),
            profileUser: Profile.empty);
}
