import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';

class Comment {
  final UserIdentification userIdentification;
  final String content;
  final DateTime timestamp;

  Comment({
    required this.userIdentification,
    required this.content,
    required this.timestamp,
  });
}
