import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/core/common/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';

// 🔹 Mock 1
final testPico = PicoModel(
  id: "1",
  picoName: "Pico Legal",
  description: "Teste",
  imgUrls: ["url"],
  modalidade: "Skate",
  tipoPico: "rua",
  longitude: -46.57421,
  latitude: -23.55052,
  atributos: {"teste": 2},
  obstaculos: ["corrimão"],
  utilities: ["banheiro"],
  reviewersUsers: ["user123"],
  idPostOnThis: [],
  nota: 4.5,
  avaliacoes: 10,
  userIdentification: UserIdentification(
    id: "980302",
    name: "user123",
    photoUrl: "url.com.photo"
  ),
);

// 🔹 Mock 2
final testPico2 = PicoModel(
  id: "2",
  picoName: "Pico Chave",
  description: "Teste",
  imgUrls: ["url"],
  modalidade: "BMX",
  tipoPico: "rua",
  longitude: -46.57421,
  latitude: -23.55052,
  atributos: {"teste": 2},
  obstaculos: ["corrimão"],
  utilities: ["banheiro"],
  reviewersUsers: ["user123"],
  idPostOnThis: [],
  nota: 4.5,
  avaliacoes: 10,
  userIdentification: UserIdentification(
    id: "209094",
    name: "user123",
    photoUrl: "url.com.photo"
  ),
);

// 🔹 Mock 3
final testPico3 = PicoModel(
  id: "3",
  picoName: "Pico Dhora",
  description: "Teste",
  imgUrls: ["url"],
  modalidade: "Skate",
  tipoPico: "rua",
  longitude: -46.57421,
  latitude: -23.55052,
  atributos: {"teste": 2},
  obstaculos: ["corrimão"],
  utilities: ["banheiro"],
  reviewersUsers: ["user123"],
  idPostOnThis: [],
  nota: 4.5,
  avaliacoes: 10,
  userIdentification: UserIdentification(
    id: "23413",
    name: "user123",
    photoUrl: "url.com.photo"
  ),
);

// 🔹 Lista de spots para testes
final listSpots = [testPico, testPico2, testPico3];

// 🔹 Mapper com DTO do Firebase
final IMapperDto mapper = FirebaseDtoMapper<PicoModel>(
  fromJson: (data, id) => PicoModel.fromJson(data, id),
  toMap: (model) => model.toMap(),
  getId: (model) => model.id,
);

// 🔹 DTOs mockados para testar repository
final listDto = listSpots.map((pico) => mapper.toDTO(pico) as FirebaseDTO).toList();
