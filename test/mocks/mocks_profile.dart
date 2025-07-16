import 'package:demopico/features/user/domain/enums/sign_methods.dart';
import 'package:demopico/features/user/domain/models/user.dart';

final mockUserProfile = UserM(
  name: 'artu',
  description: 'marretando',
  id: '1',
  pictureUrl: '',
  isColetivo: false,
  signMethod: SignMethods.email,
  location: '',
  dob: '',
  conexoes: 0,
  picosAdicionados: 0,
  picosSalvos: 0,
  favoritesIdPicos: [],
  myIdPosts: [],
  email: '',
  backgroundPicture: '',
);

  final testeProfileErrado = UserM(
   name: 'artu' ,
   description: null,
   id: "ID",
   pictureUrl: null,
   isColetivo: false,
   signMethod: SignMethods.email,
   location:'',
   dob:'',
   conexoes: 0,
   picosAdicionados: 0,
    favoritesIdPicos: [],
    backgroundPicture: "HTTP.COM",
    email: "EMAILiNVAÁLIDO",
    myIdPosts: [],
    picosSalvos: -1,
    
  );

