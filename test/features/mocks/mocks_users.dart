import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/value_objects/dob_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/core/common/auth/infra/mapper/user_mapper.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
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


// --- Mocks para testes entidades  ---

// Mock de um usuário completo.
final userMock1 = UserEntity(
  id: 'uid-12345',
  displayName: VulgoVo('Ana Beatriz'),
  email: EmailVO('ana.b@example.com'),
  dob: DobVo(DateTime(1995, 8, 22)),
  location: LocationVo(latitude: -23.550520, longitude: -46.633308), // São Paulo
  profileUser: ProfileFactory.initialFromUser(
    'uid-12345',
    'Ana Beatriz',
    'https://i.pravatar.cc/150?u=ana',
  ),
  avatar: 'https://i.pravatar.cc/150?u=ana',
);

// Mock de um segundo usuário, sem localização.
final userMock2 = UserEntity(
  id: 'uid-67890',
  displayName: VulgoVo('Carlos Daniel'),
  email: EmailVO('carlos.d@example.com'),
  dob: DobVo(DateTime(2001, 2, 10)),
  location: null, // Usuário sem localização definida
  profileUser: ProfileFactory.initialFromUser(
    'uid-67890',
    'Carlos Daniel',
    'https://i.pravatar.cc/150?u=carlos',
  ),
  avatar: 'https://i.pravatar.cc/150?u=carlos',
);

// Mock de um terceiro usuário usando o factory `initial`.
final userMock3 = UserEntity.initial(
  'uid-abcde',
  VulgoVo('Juliana Lima'),
  EmailVO('juliana.lima@example.com'),
  LocationVo(latitude: -22.906847, longitude: -43.172897), // Rio de Janeiro
  'https://i.pravatar.cc/150?u=juliana',
);

final userI = UserMapper.mapUserModelToUserIdentification(UserMapper.fromEntity(userMock1));
// Mock para a entidade ColetivoEntity.
final coletivoMock = ColetivoEntity(
  id: 'coletivo-tech-sp',
  modarator: userI, // Ana é a moderadora
  members: [userI, userI], // Carlos e Juliana são membros
  logo: 'https://i.pravatar.cc/150?u=coletivo',
  nameColetivo: "legal",
  publications: [],  
);

// Mock para o usuário anônimo.
final anonymousUserMock = AnonymousUserEntity();


// --- Lista pronta para retornar em um stub ---
// Você pode usar esta lista para simular o retorno de uma API, por exemplo.
final List<User> mockUserList = [
  userMock1,
  userMock2,
  userMock3,
  anonymousUserMock,
];