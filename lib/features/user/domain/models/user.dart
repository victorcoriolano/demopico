import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/user/domain/enums/auth_enum.dart';
import 'package:demopico/features/user/domain/enums/sign_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserM {
  String? id;
  String? name;
  String? email;
  bool? isColetivo;
  String? dob;
  SignMethods? signMethod;
  AuthEnumState? authEnumState = AuthEnumState.notLoggedIn;

  //dados profile
  String? description;
  String? pictureUrl;
  String? location;
  int? conexoes;
  int? picosAdicionados;
  int? picosSalvos;
  String? backgroundPicture;

  UserM copyWith({
    String? id,
    String? name,
    String? email,
    bool? isColetivo,
    String? dob,
    SignMethods? signMethod,
    AuthEnumState? authEnumState,
    String? description,
    String? pictureUrl,
    String? location,
    int? conexoes,
    int? picosAdicionados,
    int? picosSalvos,
    String? backgroundPicture
  }) {
    return UserM(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isColetivo: isColetivo ?? this.isColetivo,
      dob: dob ?? this.dob,
      signMethod: signMethod ?? this.signMethod,
      authEnumState: authEnumState ?? this.authEnumState,
      description: description ?? this.description,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      location: location ?? this.location,
      conexoes: conexoes ?? this.conexoes,
      picosAdicionados: picosAdicionados ?? this.picosAdicionados,
      picosSalvos: picosSalvos ?? this.picosSalvos,
      backgroundPicture: backgroundPicture ?? this.backgroundPicture,
    );
  }
  

  //transforma dados do firebase em dados na model
  //cria um user model de acordo com a nova conta criada
  factory UserM.userFromFirebaseAuthUser(
      User user, String name, bool coletivo) {
    String todayDate =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    return UserM(
      name: name,
      email: user.email,
      description: 'Edite para atualizar sua bio',
      id: user.uid,
      picosAdicionados: 0,
      picosSalvos: 0,
      location: '',
      conexoes: 0,
      dob: todayDate,
      authEnumState: AuthEnumState.notDetermined,
      pictureUrl: "https://firebasestorage.googleapis.com/v0/b/pico-skatepico.appspot.com/o/users%2FfotoPadrao%2FuserPhoto.png?alt=media&token=c48f5406-fac1-4b35-b2a7-453e2fb57427",
      isColetivo: coletivo,
      backgroundPicture: "",
    );
  }

  factory UserM.fromDocument(DocumentSnapshot doc) {
    return UserM.withRequired(
      name: doc['name'] ?? "",
      description: doc['description'] ?? "",
      id: doc['id'] ?? "",
      location: doc['location'] ?? '',
      picosSalvos: doc['picosSalvos'] ?? 0,
      pictureUrl: doc['pictureUrl'] ?? '',
      backgroundPicture: doc['backgroundPicture'] ?? '',
      isColetivo: doc['isColetivo'] ?? false,
      signMethod: SignMethods.fromString(doc['signMethod'] ?? "email"),
      authEnumState: AuthEnumState.loggedIn,
      email: doc['email'] ?? "",
      dob: doc['dob'] ?? "2022-01-01",
      conexoes: doc['conexoes'] ?? 0,
      picosAdicionados: doc['picosAdicionados'] ?? 0,
    );
  }

  

  factory UserM.fromSnapshot(QuerySnapshot doc) {
    return UserM(email: "email");
  }
  Map<String, dynamic> toJsonMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['id'] = id;
    data['pictureUrl'] = pictureUrl;
    data['backgroundPicture'] = backgroundPicture;
    data['location'] = location;
    data['dob'] = dob;
    data['conexoes'] = conexoes;
    data['picosAdicionados'] = picosAdicionados;
    data['picosSalvos'] = picosSalvos;
    data['isColetivo'] = isColetivo;
    data['signMethod'] = signMethod!.name;
    data['email'] = email;
    data['authEnumState'] = authEnumState.toString().split('.').last;
    return data;
  }

  bool get stringify => true;

  @override
  String toString() {
    if (stringify) {
      return 'User{name: $name, description: $description, id: $id, pictureUrl: $pictureUrl, isColetivo: $isColetivo, signMethod: $signMethod, email: $email, authEnumState: $authEnumState, location: $location, dob: $dob, conexoes: $conexoes, picosAdicionados: $picosAdicionados, picosSalvos: $picosSalvos}';
    } else {
      return 'String data was not reached.';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserM &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          id == other.id &&
          pictureUrl == other.pictureUrl &&
          isColetivo == other.isColetivo &&
          signMethod == other.signMethod;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      id.hashCode ^
      pictureUrl.hashCode ^
      isColetivo.hashCode ^
      signMethod.hashCode;

  List<Object?> get props => [
        name,
        description,
        id,
        pictureUrl,
        isColetivo,
        signMethod,
      ];

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  UserM(
      {this.name,
      this.description,
      this.id,
      this.pictureUrl,
      this.isColetivo,
      this.signMethod,
      this.location,
      this.dob,
      this.conexoes,
      this.picosAdicionados,
      this.picosSalvos,
      this.authEnumState,
      this.email, 
      this.backgroundPicture});

      UserM.withRequired(
      {required this.name,
      required this.description,
      required this.id,
      required this.pictureUrl,
      required this.isColetivo,
      required this.signMethod,
      required this.location,
      required this.dob,
      required this.conexoes,
      required this.picosAdicionados,
      required this.picosSalvos,
      required this.authEnumState,
      required this.email, 
      required this.backgroundPicture});
}
