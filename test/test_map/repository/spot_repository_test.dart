import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:demopico/features/mapa/data/services/firebase_spots_service.dart';
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
  group("Deve testar a interação com o firebase ", () {
    //variáveis mockadas para utilizar nos testes
    late MockFirebaseFirestore mockFirestore;
    late MockCollectionReference mockCollection;
    late MockDocumentReference mockDocRef;
    late MockDocumentSnapshot mockDocSnapshot;
    late FirebaseSpotsService repositoryMap;
    late MockQuerySnapshot mockQuerySnapshot;
    late MockQueryDocumentSnapshot mockQueryDocSnapshot;

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
    
    final testPicoNotaNova = testPico.copyWith(nota: 5, numeroAvaliacoes: 11);

    //setando os mocks para utilizar nos testes
    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      mockCollection = MockCollectionReference();
      mockDocSnapshot = MockDocumentSnapshot();
      mockDocRef = MockDocumentReference();
      mockQuerySnapshot = MockQuerySnapshot();
      mockQueryDocSnapshot = MockQueryDocumentSnapshot();

      repositoryMap = FirebaseSpotsService(mockFirestore);
    });

    //testando criar pico
    test("deve criar um pico com sucesso e retornar a instancia como pico",
        () async {
      // criando fluxo que ocorrerá se der tudo certo
      when(mockFirestore.collection("spots")).thenReturn(mockCollection);
      when(mockCollection.add(testPico.toJson()))
          .thenAnswer((_) async => mockDocRef);
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

    test("deve criar uma stream e retornar todos os picos do firebase",
        () async {
      final controllerStream =
          StreamController<QuerySnapshot<Map<String, dynamic>>>();
      controllerStream.add(mockQuerySnapshot);
      when(mockFirestore.collection("spots")).thenReturn(mockCollection);
      when(mockCollection.snapshots())
          .thenAnswer((_) => controllerStream.stream);

      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocSnapshot]);
      when(mockQueryDocSnapshot.data()).thenReturn(testPico.toJson());

      final resul = repositoryMap.loadSpots();
      controllerStream.add(mockQuerySnapshot);

      expect(resul, isA<Stream<List<PicoModel>>>());

      expectLater(
        resul,
        emits(isA<List<PicoModel>>().having(
            (picos) => picos.first.picoName, 'picoName', testPico.picoName)),
      );

      await controllerStream.close();
    });

    test("deve criar uma stream e retornar os picos filtrados do firebase",
        () async {
      final controllerStream =
          StreamController<QuerySnapshot<Map<String, dynamic>>>();

      controllerStream.add(mockQuerySnapshot);
      when(mockFirestore.collection("spots")).thenReturn(mockCollection);
      when(mockCollection.snapshots())
          .thenAnswer((_) => controllerStream.stream);

      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocSnapshot]);
      when(mockQueryDocSnapshot.data()).thenReturn(testPico.toJson());

      final resul = repositoryMap.loadSpots();
      controllerStream.add(mockQuerySnapshot);

      expect(resul, isA<Stream<List<PicoModel>>>());

      await expectLater(
        resul,
        emits(isA<List<PicoModel>>().having(
            (picos) => picos.first.picoName, 'picoName', testPico.picoName)),
      );

      await controllerStream.close();
    });    


    test("deve atualizar a nota do pico", () async {
      when(mockFirestore.collection("spots")).thenReturn(mockCollection);
      when(mockCollection.doc('1')).thenReturn(mockDocRef);
      when(mockDocRef.get(any)).thenAnswer((_) async => mockDocSnapshot);
      when(mockDocSnapshot.data()).thenReturn(testPicoNotaNova.toJson());
      when(mockDocSnapshot.exists).thenReturn(true);
      when(mockDocSnapshot.reference).thenReturn(mockDocRef);
      when(mockDocRef.update({"nota": 5.0, 'avaliacoes': 11}))
          .thenAnswer((_) async {});

      final result = await repositoryMap.updateSpot(testPicoNotaNova);
      expect(result, isA<PicoModel>());
      expect(result.nota, 5.0);
      expect(result.numeroAvaliacoes, 11);
    });

    test("deve deletar um pico", () async {
      when(mockFirestore.collection("spots")).thenReturn(mockCollection);
      when(mockCollection.doc('1')).thenReturn(mockDocRef);
      when(mockDocRef.delete()).thenAnswer((_) async {});
      when(mockDocRef.get(any)).thenAnswer((_) async {
        final snapshotDeleted = MockDocumentSnapshot();
        when(snapshotDeleted.exists).thenReturn(false);
        return snapshotDeleted;
      });

      await repositoryMap.deleteSpot("1");

      verify(mockDocRef.delete()).called(1);
      expect(mockDocRef.delete(), completes);

      //verificando se o pico foi deletado
      final snapshotDel = await mockDocRef.get();
      expect(snapshotDel.exists, isFalse);
    });

    test(
        'deve lançar uma exceção quando o documento não existir depois da criação',
        () async {
      when(mockFirestore.collection('spots')).thenReturn(mockCollection);
      when(mockCollection.add(testPico.toJson()))
          .thenAnswer((_) async => mockDocRef);
      when(mockDocSnapshot.exists).thenReturn(false);
      when(mockDocSnapshot.data()).thenReturn(null);
      when(mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);

      expect(() => repositoryMap.createSpot(testPico), throwsException);
    });

    test('deve lançar uma exceção quando o firebase lançar um erro', () async {
      when(mockFirestore.collection('spots')).thenReturn(mockCollection);
      when(mockCollection.add(testPico.toJson()))
          .thenThrow(FirebaseException(plugin: 'test'));

      expect(() => repositoryMap.createSpot(testPico), throwsException);
    });

    test(
        'deve lança uma exceção quando o documento existir mais os dados forem nulos',
        () async {
      when(mockFirestore.collection('spots')).thenReturn(mockCollection);
      when(mockCollection.add(testPico.toJson()))
          .thenAnswer((_) async => mockDocRef);
      when(mockDocSnapshot.exists).thenReturn(true); //domento existe
      when(mockDocSnapshot.data()).thenReturn(null); //dados nulos
      when(mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);

      expect(() => repositoryMap.createSpot(testPico), throwsException);
    });

    test('deve saber lidar com erros inesperados', () async {
      when(mockFirestore.collection('spots')).thenReturn(mockCollection);
      when(mockCollection.add(testPico.toJson()))
          .thenThrow(Exception('Unexpected error'));

      expect(() => repositoryMap.createSpot(testPico), throwsException);
    });
  });
}
