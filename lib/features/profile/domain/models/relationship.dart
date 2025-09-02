
sealed class ReciverRequesterBase {
  String id;
  String name;
  String? profilePictureUrl;

  ReciverRequesterBase({required this.id, required this.name, required this.profilePictureUrl});
}

class ConnectionReceiver extends ReciverRequesterBase {

  ConnectionReceiver({required super.id, required super.name, required super.profilePictureUrl});

  factory ConnectionReceiver.fromJson(Map<String, dynamic> json) {
    return ConnectionReceiver(
      id: json['id'],
      name: json['name'],
      profilePictureUrl: json['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}

class ConnectionRequester extends ReciverRequesterBase {

  ConnectionRequester({required super.id, required super.name, required super.profilePictureUrl});

  factory ConnectionRequester.fromJson(Map<String, dynamic> json) {
    return ConnectionRequester(
      id: json['id'],
      name: json['name'],
      profilePictureUrl: json['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}

class Relationship {
  String id;
  ConnectionRequester requesterUser;
  ConnectionReceiver addressed;
  RequestConnectionStatus status;
  DateTime createdAt;
  DateTime updatedAt;

  Relationship({required this.id, required this.requesterUser, required this.addressed, required this.status, required this.createdAt, required this.updatedAt});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requesterUserID': requesterUser.toJson(),
      'addresseeID': addressed.toJson(),
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
      requesterUser: ConnectionRequester.fromJson(json['requesterUserID']),
      status: RequestConnectionStatus.fromString(json['status']),
      addressed: ConnectionReceiver.fromJson(json['addresseeID']),
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
