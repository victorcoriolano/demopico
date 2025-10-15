import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';


class Relationship {
  String id;
  UserIdentification requesterUser;
  UserIdentification addressed;
  RequestConnectionStatus status;
  DateTime createdAt;
  DateTime updatedAt;

  Relationship({required this.id, required this.requesterUser, required this.addressed, required this.status, required this.createdAt, required this.updatedAt});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requesterData': requesterUser.toJson(),
      'addressedData': addressed.toJson(),
      'requesterUserID': requesterUser.id,
      'addressedID': addressed.id,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(), 
    };
  }

  factory Relationship.fromJson(Map<String, dynamic> json, String id) {
    return Relationship(
      updatedAt: DateTime.parse(json['updatedAt']),
      id: id,
      createdAt: DateTime.parse(json['createdAt']),
      requesterUser: UserIdentification.fromJson(json['requesterData']),
      status: RequestConnectionStatus.fromString(json['status']),
      addressed: UserIdentification.fromJson(json['addressedData']),
    );
  }

  Relationship copyWith({
    String? id,
    UserIdentification? requesterUser,
    UserIdentification? addressed,
    RequestConnectionStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Relationship(
      id: id ?? this.id,
      requesterUser: requesterUser ?? this.requesterUser,
      addressed: addressed ?? this.addressed,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }


  bool hasId(String id){
    return addressed.id == id || requesterUser.id == id;
  }

  bool hasBothID(String id1, String id2){
    return hasId(id1) && hasId(id2); 
  }

}


enum RequestConnectionStatus{
  pending,
  accepted,
  available,
  rejected;

  String get name {
    switch (this) {
      case RequestConnectionStatus.pending:
        return 'pending';
      case RequestConnectionStatus.accepted:
        return 'accepted';
      case RequestConnectionStatus.rejected:
        return 'rejected';
      case RequestConnectionStatus.available:
        return 'available';
    }
  }

  String get statusForSuggestions {
    switch (this) {
      case RequestConnectionStatus.pending:
        return 'Enviado';
      case RequestConnectionStatus.accepted:
        return 'Conectado';
      case RequestConnectionStatus.rejected:
        return 'Conectar';
      case RequestConnectionStatus.available:
        return 'Conectar';
    }
  }

  factory RequestConnectionStatus.fromString(String value) {
    switch (value) {
      case 'available':
        return RequestConnectionStatus.available;
      case 'pending':
        return RequestConnectionStatus.pending;
      case 'accepted':
        return RequestConnectionStatus.accepted;
      case 'rejected':
        return RequestConnectionStatus.rejected;
      default:
        throw ArgumentError("Invalid connection status");
    }
  }
}
