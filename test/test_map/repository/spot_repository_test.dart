

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/models/pico_model.dart';
import 'package:demopico/features/mapa/data/repository/firebase_repository_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'spot_repository_test.mocks.dart';






//cirando anotação para criar o mock
@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<QueryDocumentSnapshot<Map<String, dynamic>>>(),
])



void main() {
  group("Testando o firebase repository dos métodos hard do pico", () {

    //variáveis mockadas para utilizar nos testes 
    late MockFirebaseFirestore mockFirestore;
    late MockCollectionReference mockCollection; 
    late MockDocumentReference mockDocRef; 
    late MockDocumentSnapshot mockDocSnapshot; 
    late FirebaseRepositoryMap repositoryMap;
    late MockQuerySnapshot mockQuerySnapshot;
    late MockQueryDocumentSnapshot mockQueryDocSnapshot;

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
    
    //setando os mocks para utilizar nos testes
    setUp((){
       mockFirestore = MockFirebaseFirestore();
       mockCollection = MockCollectionReference();
       mockDocSnapshot = MockDocumentSnapshot();
       mockDocRef = MockDocumentReference();  
       mockQuerySnapshot = MockQuerySnapshot();
       mockQueryDocSnapshot = MockQueryDocumentSnapshot();

       repositoryMap = FirebaseRepositoryMap(mockFirestore);
    });
    
    //testando criar pico
    test("deve criar um pico com sucesso e retornar a instancia como pico", () async  {
      // criando fluxo que ocorrerá se der tudo certo 
      when(mockFirestore.collection("spots")).thenReturn(mockCollection);
      when(mockCollection.add(testPico.toJson())).thenAnswer((_) async => mockDocRef);
      when(mockDocSnapshot.id).thenReturn("1");  
      when(mockDocSnapshot.exists).thenReturn(true);
      when(mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);
      when(mockDocSnapshot.data()).thenReturn(testPico.toJson());

      //chamando o método
      final result = await repositoryMap.createSpot(testPico);

      //verificando os resultados 
      expect(result, isA<PicoModel>());
      expect(result!.id, "1");
      expect(result.picoName, "Pico Legal");
      
    });

    test("deve listar os picos salvos", () async{
      when(mockFirestore.collection("spots")).thenReturn(mockCollection);
      when(mockCollection.get(any)).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocSnapshot]); 
      when(mockQueryDocSnapshot.data()).thenReturn(testPico.toJson());
      when(mockQueryDocSnapshot.id).thenReturn("1");

      final resul = await repositoryMap.showAllPico();
      expect(resul, isA<List<PicoModel>>());
    });
  });
  
}





 