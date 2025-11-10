import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/value_objects/dob_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';

class UserMapper {
  
  /// Converte UserM (model) para UserEntity (entidade de domínio)
  static UserEntity toEntity(UserM model, Profile profileUser) {
    return UserEntity(
      avatar: model.avatar,
      id: model.id,
      displayName: VulgoVo(model.name),
      email: EmailVO(model.email),
      dob: DobVo(model.dob),
      location: (model.latitude != null && model.longitude != null)
          ? LocationVo(latitude: model.latitude!,longitude: model.longitude!)
          : null,
      profileUser: profileUser,// referência ao profile
    );
  }

  /// Converte UserEntity (entidade) para UserM (model)
  static UserM fromEntity(UserEntity entity) {
    return UserM(
      id: entity.id,
      name: entity.displayName.value,
      email: entity.email.value,
      dob: entity.dob.value,
      latitude: entity.location?.latitude,
      longitude: entity.location?.longitude,
    );
  }

  static UserIdentification mapUserModelToUserIdentification(UserM userm) {
    return UserIdentification(
      id: userm.id, 
      name: userm.name, 
      profilePictureUrl: userm.avatar);
  }
}
