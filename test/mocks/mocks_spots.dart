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