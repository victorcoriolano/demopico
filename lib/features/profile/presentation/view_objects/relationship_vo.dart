import 'package:demopico/features/profile/domain/models/relationship.dart';

class RelationshipVo {
  final ReciverRequesterBase addressed;
  final ReciverRequesterBase requester;
  final String idRelationship;
  RequestConnectionStatus? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  RelationshipVo({
    required this.idRelationship,
    required this.addressed,
    required this.requester,
     this.status,
     this.createdAt,
     this.updatedAt,

  });

  
}