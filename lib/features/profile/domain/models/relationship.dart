

class Relationship {
  String id;
  String requesterUserID;
  String addresseeID;
  RequestConnectionStatus status;
  DateTime createdAt;
  DateTime updatedAt;

  Relationship({required this.id, required this.requesterUserID, required this.addresseeID, required this.status, required this.createdAt, required this.updatedAt});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requesterUserID': requesterUserID,
      'addresseeID': addresseeID,
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
      requesterUserID: json['requesterUserID'],
      status: RequestConnectionStatus.fromString(json['status']),
      addresseeID: json['addresseeID'],
    );
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
