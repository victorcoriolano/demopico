import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';

class Comment {
  final UserIdentification userIdentification;
  final String picoId;
  final String content;
  final DateTime timestamp;
  
  Comment({
    required this.userIdentification,
    required this.picoId,
    required this.content,
    required this.timestamp,
  });
}
