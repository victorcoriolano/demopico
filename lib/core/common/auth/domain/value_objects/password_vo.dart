
import 'package:demopico/core/common/errors/domain_failures.dart';

class PasswordVo {
  final String value;

  PasswordVo._(this.value);

  factory PasswordVo(String value) {
    if (value.length < 8) {
      throw InvalidPasswordFailure();
    }
    return PasswordVo._(value);
  }

  factory PasswordVo.empty(){
    return PasswordVo._("");
  }
}