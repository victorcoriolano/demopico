import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/enums/sign_methods.dart';


class UserM {
  String id;
  String name;
  String email;
  bool isColetivo;
  String dob;
  SignMethods signMethod;

  //dados profile
  String? description;
  String? pictureUrl;
  String? location;
  int conexoes;
  int picosAdicionados;
  int picosSalvos;
  String backgroundPicture;
  List<Pico>? favoritePicosEntities;
  List<Post>? myPostsEntities;
  List<String> myIdPosts;
  List<String> favoritesIdPicos;
  List<String> idMySpots;

  UserM copyWith({
    List<String>? myIdPosts,
    List<String>? favoritesIdPicos,
    List<Post>? myPosts,
    String? id,
    String? name,
    String? email,
    bool? isColetivo,
    String? dob,
    SignMethods? signMethod,
    List<Pico>? favoriteSpots,
    String? description,
    String? pictureUrl,
    String? location,
    int? conexoes,
    int? picosAdicionados,
    int? picosSalvos,
    String? backgroundPicture,
    List<String>? idMySpots
  }) {
    return UserM(
      idMySpots: idMySpots ?? this.idMySpots,
      favoritePicosEntities: favoriteSpots ?? favoritePicosEntities,
      myPostsEntities: myPosts ?? myPostsEntities,
      myIdPosts: myIdPosts ?? this.myIdPosts,
      favoritesIdPicos: favoritesIdPicos ?? this.favoritesIdPicos,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isColetivo: isColetivo ?? this.isColetivo,
      dob: dob ?? this.dob,
      signMethod: signMethod ?? this.signMethod,
      description: description ?? this.description,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      location: location ?? this.location,
      conexoes: conexoes ?? this.conexoes,
      picosAdicionados: picosAdicionados ?? this.picosAdicionados,
      picosSalvos: picosSalvos ?? this.picosSalvos,
      backgroundPicture: backgroundPicture ?? this.backgroundPicture,
    );
  }
  

  //transforma dados de autenticação em dados na model
  //cria um user model de acordo com a nova conta criada
  factory UserM.initial(UserCredentialsSignUp authUser) {
    String todayDate =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    return UserM(
      idMySpots: [],
      myIdPosts: [],
      favoritesIdPicos: [],
      signMethod: authUser.signMethod,
      name: authUser.nome,
      email: authUser.email,
      description: 'Edite para atualizar sua bio',
      id: authUser.uid,
      picosAdicionados: 0,
      picosSalvos: 0,
      location: '',
      conexoes: 0,
      dob: todayDate,
      pictureUrl: "https://firebasestorage.googleapis.com/v0/b/pico-skatepico.appspot.com/o/users%2FfotoPadrao%2FuserPhoto.png?alt=media&token=c48f5406-fac1-4b35-b2a7-453e2fb57427",
      isColetivo: authUser.isColetivo,
      backgroundPicture: "",
    );
  }

  factory UserM.fromJson(Map<String,dynamic> json, String id) {
    return UserM(
      idMySpots: List<String>.from(json['mySpots'] ?? []),
      myIdPosts: List<String>.from(json['myPosts'] ?? []),
      favoritesIdPicos: json['favoritesSpots'] ?? [],
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      id: id,
      location: json['location'] ?? '',
      picosSalvos: json['picosSalvos'] ?? 0,
      pictureUrl: json['pictureUrl'] ?? '',
      backgroundPicture: json['backgroundPicture'] ?? '',
      isColetivo: json['isColetivo'] ?? false,
      signMethod: SignMethods.fromString(json['signMethod'] ?? "email"),
      email: json['email'] ?? "",
      dob: json['dob'] ?? "2022-01-01",
      conexoes: json['conexoes'] ?? 0,
      picosAdicionados: json['picosAdicionados'] ?? 0,
    );
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
    data['signMethod'] = signMethod.name;
    data['email'] = email;
    data['favoriteSpots'] = favoritesIdPicos;
    data['myPosts'] = myIdPosts;
    data['mySpots'] = idMySpots;
    return data;
  }

  bool get stringify => true;

  @override
  String toString() {
    if (stringify) {
      return 'User{name: $name, description: $description, id: $id, pictureUrl: $pictureUrl, isColetivo: $isColetivo, signMethod: $signMethod, email: $email, signMethod: $signMethod, location: $location, dob: $dob, conexoes: $conexoes, picosAdicionados: $picosAdicionados, picosSalvos: $picosSalvos}';
    } else {
      return 'String data was not reached.';
    }
  }

  bool isMy(String idPost) => idPost == id; 

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
      {
         this.favoritePicosEntities,
        this.myPostsEntities,
        required this.favoritesIdPicos,
        required this.myIdPosts,
        required this.name,
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
      required this.email, 
      required this.backgroundPicture,
      required this.idMySpots});

}
