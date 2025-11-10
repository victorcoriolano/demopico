import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/features/user/domain/enums/sign_methods.dart';



class EmailCredentialsSignIn  {
  final EmailVO identifier;
  final PasswordVo senha;
  final SignMethods signMethod;

  EmailCredentialsSignIn({
    SignMethods? signMethods,
    required this.identifier,
    required this.senha,
  }) : signMethod = signMethods ?? SignMethods.email;
}

class VulgoCredentialsSignIn  {
  VulgoCredentialsSignIn({
    required this.password,
    required this.vulgo,
  });

  final PasswordVo password;
  final VulgoVo vulgo;
}

class GoogleCredentialsSignIn  {
  GoogleCredentialsSignIn({
    required this.token,
  });

  final String token;
}


class NormalUserCredentialsSignUp {
  NormalUserCredentialsSignUp({
    required this.vulgo,
    required this.email,
    required this.password,
    this.avatar,
    this.location,
  });

  final VulgoVo vulgo;
  final EmailVO email;
  final PasswordVo password;
  final String? avatar;
  final LocationVo? location;

}
