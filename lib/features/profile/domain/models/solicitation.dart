
import 'package:demopico/features/profile/domain/models/convite.dart';

class Solicitation {
  final String id;
  final String idCollective;
  final String nameUser;
  final String nameCollective;
  final Status status;
  Solicitation({
    required this.id,
    required this.nameUser,
    required this.nameCollective,
    required this.idCollective,
    required this.status,
  });

  String get message => "$nameUser quer participar do $nameCollective";
}