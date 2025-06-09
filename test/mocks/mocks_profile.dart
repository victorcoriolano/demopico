import 'package:demopico/features/user/domain/enums/sign_methods.dart';
import 'package:demopico/features/user/domain/models/user.dart';

final mockUserProfile = UserM.withRequired(
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
  authEnumState: null,
  email: '',
  backgroundPicture: '',
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

