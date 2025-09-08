import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';

abstract class AuthCredentials {}

class EmailPasswordCredentials extends AuthCredentials {
  final EmailVO email;
  final PasswordVo password;

  EmailPasswordCredentials({required this.email, required this.password});
}

class VulgoPasswordCredentials extends AuthCredentials {
  final String vulgo;
  final PasswordVo password;

  VulgoPasswordCredentials({required this.vulgo, required this.password});
}

class AnonymousCredentials extends AuthCredentials {
  final String deviceId; // unique device identifier
  AnonymousCredentials({required this.deviceId});
}

class GoogleCredentials extends AuthCredentials {
  final String idToken; // token received from google sdk
  GoogleCredentials({required this.idToken});
}
