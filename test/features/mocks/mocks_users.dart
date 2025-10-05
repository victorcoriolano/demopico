import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';

final mockUserProfile = UserM(
  name: 'artu',

  id: '1',

  dob:DateTime.now(),
  email: 'test@email.com',
);

final mockUserProfile2 = UserM(
  name: 'artu',
  id: '2',

  dob:DateTime.now(),
  email: '',
);
final testeProfileErrado = UserM(
  name: 'artu',
  id: "ID",

  dob:DateTime.now(),
  
  email: "EMAILiNVAÁLIDO",

);

final listUsers = [mockUserProfile, mockUserProfile2, testeProfileErrado];

final listDtosUser = listUsers.map((user) {
  return FirebaseDTO(id: user.id, data: user.toJson());
}).toList();
