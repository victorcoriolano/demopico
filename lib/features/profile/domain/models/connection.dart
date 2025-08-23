
class Connection {
  String id;
  String userID;
  String connectedUserID;
  RequestConnectionStatus status;


  Connection({required this.id, required this.userID, required this.connectedUserID, required this.status});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'connectedUserID': connectedUserID,
      'status': status.name,
    };
  }

  factory Connection.fromJson(Map<String, dynamic> json, String id) {
    return Connection(
      id: id,
      userID: json['userID'],
      status: RequestConnectionStatus.fromString(json['status']),
      connectedUserID: json['connectedUserID'],
    );
  }
}


enum RequestConnectionStatus{
  pending,
  accepted,
  rejected;

  String get name {
    switch (this) {
      case RequestConnectionStatus.pending:
        return 'pending';
      case RequestConnectionStatus.accepted:
        return 'accepted';
      case RequestConnectionStatus.rejected:
        return 'rejected';
    }
  }

  factory RequestConnectionStatus.fromString(String value) {
    switch (value) {
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