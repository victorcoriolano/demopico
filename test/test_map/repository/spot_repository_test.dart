import 'dart:async';

import 'package:demopico/features/mapa/data/data_sources/remote/firebase_spot_remote_datasource.dart';
import 'package:demopico/features/mapa/data/mappers/mapper_dto_picomodel.dart';
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks_spots.dart';

//cirando anotação para criar o mock

class MockDatasource extends Mock implements FirebaseSpotRemoteDataSource {}

void main() {
  group("Deve testar a interação com o firebase ", () {
    //variáveis mockadas para utilizar nos testes

    late MockDatasource mockDatasource;
    late SpotRepositoryImpl repositoryImpl;

    final testPicoNotaNova = testPico.copyWith(nota: 5, numeroAvaliacoes: 11);

    //setando os mocks para utilizar nos testes
    setUpAll(() {
      mockDatasource = MockDatasource();
      repositoryImpl = SpotRepositoryImpl(mockDatasource);
    });

    //testando criar pico
    test("deve criar um pico com sucesso e retornar a instancia como pico",
        () async {
      // criando fluxo que ocorrerá se der tudo certo
      when(() => mockDatasource.create(any()))
          .thenAnswer((_) => Future.value(MapperDtoPicomodel.toDto(testPico)));

      //chamando o método
      final result = await repositoryImpl.createSpot(testPico);

      //verificando os resultados
      expect(result, isA<PicoModel>());
      expect(result.id, "1");
      expect(result.picoName, "Pico Legal");
    });

    test("deve criar uma stream e retornar os dados do datasource", () {
      when(() => mockDatasource.load())
          .thenAnswer((_) => Stream.value(listDto));

      final result = repositoryImpl.loadSpots();
      expect(result, isA<Stream<List<PicoModel>>>());

      //verificando se retora a lista de picos
      expectLater(
        result,
        emitsInOrder([
          isA<List<PicoModel>>()
              .having((lista) => lista.length, "deve conter 3", equals(3)),
        ]),
      );
    });

    test("deve atualizar um pico", () async {
      when(() => mockDatasource.update(MapperDtoPicomodel.toDto(testPicoNotaNova))).thenAnswer((_) async {});

      final result = await repositoryImpl.updateSpot(testPicoNotaNova);
      expect(result, isA<PicoModel>());

    });

    /* 


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
    }); */
  });
}

Future<void> retornarVoid() async {
  return;
}
