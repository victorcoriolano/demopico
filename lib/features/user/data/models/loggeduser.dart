import 'package:demopico/features/user/data/models/user.dart';

class LoggedUserModel extends UserM {
  LoggedUserModel.empty() : super();
  LoggedUserModel({required UserM user}) {
    super.name = user.name;
    super.description = user.description;
    super.image = user.image;
    super.id = user.id;
    super.pictureUrl = user.pictureUrl;
    super.isColetivo = user.isColetivo;
    super.signMethod = user.signMethod;
    super.email = user.email;
    super.authEnumState = user.authEnumState;
    super.location = user.location;
    super.dob = user.dob;
    super.conexoes = user.conexoes;
    super.picosAdicionados = user.picosAdicionados;
    super.picosSalvos = user.picosSalvos;
  }

  String get getName => super.name as String;

  String get getEmail => super.email as String;

  String get getPictureUrl => super.pictureUrl as String;

  String get getId => super.id as String;

  String get getAuthEnumState => super.authEnumState.toString();

  String get getSignMethod => super.signMethod.toString();

  String get getConexoes => super.conexoes as String;

  String get getDob => super.dob as String;

  String get getPicosAdicionados => super.picosAdicionados as String;

  String get getPicosSalvos => super.picosSalvos as String;

  String get getLocation => super.location as String;

  String get getIsColetivo => super.isColetivo.toString();

  String get getDescription => super.description as String;
}
