
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
  
    //transforma dados do firebase em dados na model
  //cria um user model de acordo com a nova conta criada
  factory UserM.userFromFirebaseAuthUser(User user, String name, bool coletivo) {
      String todayDate ='${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    return
        UserM(
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
            pictureUrl: '',
            isColetivo: coletivo,
          );
  }


  factory UserM.fromDocument(DocumentSnapshot doc) {
    return UserM(
      name: doc['name'],
      description: doc['description'],
      id: doc['id'],
      location: doc['location'],
      dob: doc['dob'],
      conexoes: doc['conexoes'],
      picosAdicionados: doc['picosAdicionados'],
      picosSalvos: doc['picosSalvos'],
      pictureUrl: doc['pictureUrl'],
      isColetivo: doc['isColetivo'],
      email: doc['email'],
    );
  }

  factory UserM.fromSnapshot(QuerySnapshot doc){
    return UserM(email: "email");


  }
Map<String, dynamic> toJsonMap() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = name;
  data['description'] = description;
  data['id'] = id;
  data['pictureUrl'] =  pictureUrl;
  data['location'] = location;
  data['dob'] = dob;
  data['conexoes'] =  conexoes;
  data['picosAdicionados'] = picosAdicionados;
  data['picosSalvos'] =  picosSalvos;
  data['isColetivo'] = isColetivo;
  data['signMethod'] = signMethod.toString().split('.').last;
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
      this.email});
}