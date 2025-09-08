
import 'package:demopico/core/common/errors/domain_failures.dart';

class PasswordVo {
  final String value;

  PasswordVo(this.value) {
    if (value.length < 8) {
      throw InvalidPasswordFailure();
    }
  }
}