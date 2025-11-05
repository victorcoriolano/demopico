
class Invitation {
  final String id;
  final String idCollective;
  final String nameCollective;
  final String idUserSent;
  final String idUserReceiver;
  final Status status;
  Invitation({
    required this.id,
    required this.nameCollective,
    required this.idCollective,
    required this.idUserSent,
    required this.idUserReceiver,
    required this.status,
  });

  String get message => "Voce foi convidado a participar do $nameCollective";
}

enum Status {
  acepted,
  refused,
  pending,
}

