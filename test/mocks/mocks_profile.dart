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
   conexoes:'',
   picosAdicionados:'',
  );

  final testeProfileErrado = UserM(
   name: 'artu' ,
   description: null,
   id: '1',
   pictureUrl:'',
   isColetivo: false,
   signMethod: SignMethods.email,
   location:'',
   dob:'',
   conexoes:'',
   picosAdicionados:'',
  );

