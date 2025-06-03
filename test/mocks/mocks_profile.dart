import 'package:demopico/features/user/domain/enums/sign_methods.dart';
import 'package:demopico/features/user/domain/models/user.dart';


  final testeProfileCerto = UserM(
   name: 'artu' ,
   description: 'marretando',
   id: '1',
   pictureUrl:'',
   isColetivo: false,
   signMethod: SignMethods.email,
   location:'',
   dob:'',
   conexoes: 0,
   picosAdicionados: 0,
  );

  final testeProfileErrado = UserM(
   name: 'artu' ,
   description: null,
   id: null,
   pictureUrl: null,
   isColetivo: false,
   signMethod: SignMethods.email,
   location:'',
   dob:'',
   conexoes: null,
   picosAdicionados: null,
  );

