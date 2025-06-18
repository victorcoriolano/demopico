
import 'package:demopico/core/common/data/dtos/firebase_dto.dart';
import 'package:demopico/core/common/data/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

final testPico = PicoModel(
      id: "1",
      imgUrls: ["url"],
      tipoPico: "rua",
      modalidade: "Skate",
      nota: 4.5,
      numeroAvaliacoes: 10,
      long: -46.57421,
      lat: -23.55052,
      description: "Teste",
      atributos: {"teste": 2},
      obstaculos: ["corrimão"],
      utilidades: ["banheiro"],
      userCreator: "user123",
      picoName: "Pico Legal",
    );

    final testPico2 = PicoModel(
      id: "1",
      imgUrls: ["url"],
      tipoPico: "rua",
      modalidade: "BMX",
      nota: 4.5,
      numeroAvaliacoes: 10,
      long: -46.57421,
      lat: -23.55052,
      description: "Teste",
      atributos: {"teste": 2},
      obstaculos: ["corrimão"],
      utilidades: ["banheiro"],
      userCreator: "user123",
      picoName: "Pico Chave",
    );

     final testPico3 = PicoModel(
      id: "",
      imgUrls: ["url"],
      tipoPico: "rua",
      modalidade: "Skate",
      nota: 4.5,
      numeroAvaliacoes: 10,
      long: -46.57421,
      lat: -23.55052,
      description: "Teste",
      atributos: {"teste": 2},
      obstaculos: ["corrimão"],
      utilidades: ["banheiro"],
      userCreator: "user123",
      picoName: "Pico Dhora",
    );

    
    final listSpots = [testPico, testPico2, testPico3];

    final IMapperDto mapper = FirebaseDtoMapper<PicoModel>(
      fromJson: (data, id) => PicoModel.fromJson(data, id),
      toMap: (model) => model.toMap(), 
      getId: (model) => model.id); 

    // mockando o dto para teste de repository
    final listDto = listSpots.map((pico) => mapper.toDTO(pico) as FirebaseDTO).toList();