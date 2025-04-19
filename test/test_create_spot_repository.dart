
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/models/pico_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';



//cirando anotação para criar o mock
@GenerateMocks([FirebaseFirestore, DocumentSnapshot, DocumentReference, CollectionReference])




void main() {
  group("Testando o firebase repository dos métodos hard do pico", () {

    final testPico = PicoModel(
      id: "1",
      imgUrls: ["url"],
      tipoPico: "rua",
      modalidade: "street",
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
    
    //testando criar pico
    test("deve criar um pico com sucesso e retornar a instancia como pico", () async  {
      // coordenando o teste
      
    });

    test("deve retornar uma excessao", () {});
  });
  
}




 