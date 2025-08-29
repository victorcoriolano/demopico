

class Connection {
  String id;
  String userID;
  String connectedUserID;
  RequestConnectionStatus status;
  DateTime createdAt;
  DateTime updatedAt;

  Connection({required this.id, required this.userID, required this.connectedUserID, required this.status, required this.createdAt, required this.updatedAt});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'connectedUserID': connectedUserID,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(), 
    };
  }

  factory Connection.fromJson(Map<String, dynamic> json, String id) {
    return Connection(
      updatedAt: DateTime.parse(json['updatedAt']),
      id: id,
      createdAt: DateTime.parse(json['createdAt']),
      userID: json['userID'],
      status: RequestConnectionStatus.fromString(json['status']),
      connectedUserID: json['connectedUserID'],
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
