
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/core/common/files_manager/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

final testPico = PicoModel(
      userID: "980302",
      id: "1",
      imgUrls: ["url"],
      tipoPico: "rua",
      modalidade: "Skate",
      newRating: 4.5,
      countReviews: 10,
      long: -46.57421,
      lat: -23.55052,
      description: "Teste",
      atributos: {"teste": 2},
      obstaculos: ["corrimão"],
      utilidades: ["banheiro"],
      userName: "user123",
      picoName: "Pico Legal",
    );

    final testPico2 = PicoModel(
      userID: "209094",
      id: "1",
      imgUrls: ["url"],
      tipoPico: "rua",
      modalidade: "BMX",
      newRating: 4.5,
      countReviews: 10,
      long: -46.57421,
      lat: -23.55052,
      description: "Teste",
      atributos: {"teste": 2},
      obstaculos: ["corrimão"],
      utilidades: ["banheiro"],
      userName: "user123",
      picoName: "Pico Chave",
    );

     final testPico3 = PicoModel(
      userID: "23413",
      id: "",
      imgUrls: ["url"],
      tipoPico: "rua",
      modalidade: "Skate",
      newRating: 4.5,
      countReviews: 10,
      long: -46.57421,
      lat: -23.55052,
      description: "Teste",
      atributos: {"teste": 2},
      obstaculos: ["corrimão"],
      utilidades: ["banheiro"],
      userName  : "user123",
      picoName: "Pico Dhora",
    );

    
    final listSpots = [testPico, testPico2, testPico3];

    final IMapperDto mapper = FirebaseDtoMapper<PicoModel>(
      fromJson: (data, id) => PicoModel.fromJson(data, id),
      toMap: (model) => model.toMap(), 
      getId: (model) => model.id); 

    // mockando o dto para teste de repository
    final listDto = listSpots.map((pico) => mapper.toDTO(pico) as FirebaseDTO).toList();