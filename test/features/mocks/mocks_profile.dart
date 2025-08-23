import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/user/domain/enums/sign_methods.dart';
import 'package:demopico/features/user/domain/models/user.dart';

final mockUserProfile = UserM(
  idMySpots: [],
  name: 'artu',
  description: 'marretando',
  id: '1',
  pictureUrl: '',
  isColetivo: false,
  signMethod: SignMethods.email,
  location: '',
  dob: '',
  connections: [],
  picosSalvos: [],
  favoritesIdPicos: [],
  myIdPosts: [],
  email: 'test@email.com',
  backgroundPicture: '',
);

final mockUserProfile2 = UserM(
  idMySpots: [],
  name: 'artu',
  description: 'aaaaaa',
  id: '2',
  pictureUrl: '',
  isColetivo: false,
  signMethod: SignMethods.email,
  location: '',
  dob: '',
  connections: [],
  picosSalvos: [],
  favoritesIdPicos: [],
  myIdPosts: [],
  email: '',
  backgroundPicture: '',
);
  final testeProfileErrado = UserM(
      idMySpots: [],
   name: 'artu' ,
   description: "",
   id: "ID",
   pictureUrl: null,
   isColetivo: false,
   signMethod: SignMethods.email,
   location:'',
   dob:'',
    connections: [],
    favoritesIdPicos: [],
    backgroundPicture: "HTTP.COM",
    email: "EMAILiNVAÁLIDO",
    myIdPosts: [],
    picosSalvos: [],
  );

  final listUsers = [
    mockUserProfile,
    mockUserProfile2,
    testeProfileErrado
  ];

  final listDtosUser = listUsers.map((user) {
    return FirebaseDTO(id: user.id, data: user.toJsonMap());
  }).toList();
