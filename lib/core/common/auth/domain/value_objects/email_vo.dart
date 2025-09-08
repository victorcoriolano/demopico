class EmailVO {
  final String value;

  EmailVO._(this.value);

  factory EmailVO(String email) {
    final normalized = email.trim().toLowerCase();
    final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    if (!emailRegex.hasMatch(normalized)) {
      throw ArgumentError('Invalid email format');
    }
    return EmailVO._(normalized);
  }
}
