import 'package:demopico/features/mapa/data/mappers/mapper_dto_picomodel.dart';
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

    // mockando o dto para teste de repository
    final listDto = listSpots.map((pico) => MapperDtoPicomodel.toDto(pico)).toList();