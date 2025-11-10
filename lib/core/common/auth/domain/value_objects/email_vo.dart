import 'package:demopico/core/common/errors/repository_failures.dart';

class EmailVO {
  final String value;

  EmailVO._(this.value);

  factory EmailVO(String email) {
    final normalized = email.trim().toLowerCase();
    final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    if (!emailRegex.hasMatch(normalized)) {
      throw InvalidEmailFailure();
    }
    return EmailVO._(normalized);
  }

  factory EmailVO.empty(){
    return EmailVO._("");
  }
}
