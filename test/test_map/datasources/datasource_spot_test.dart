
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_spot_remote_datasource.dart';
import 'package:demopico/features/mapa/data/dtos/pico_model_firebase_dto.dart';
import 'package:demopico/features/mapa/data/mappers/mapper_dto_picomodel.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mocks_spots.dart';

  void main() {
    group("deve testar o datasource de spots do cloud firestore", () {

      late FakeFirebaseFirestore fakeFirestore;
      late FirebaseSpotRemoteDataSource dataSource;

      setUpAll(() {
        fakeFirestore = FakeFirebaseFirestore();
        dataSource = FirebaseSpotRemoteDataSource(fakeFirestore);
      });

      tearDown(() {
        fakeFirestore.clearPersistence();
      });

      test("dever criar um spot no datasource e retornar um dto com id", () async {

        final result = await dataSource.create(MapperDtoPicomodel.toDto(testPico));

        expect(result, isA<PicoFirebaseDTO>());
        expect(result.data, isA<Map<String, dynamic>>());
        expect(result.id, isA<String>());
        debugPrint(result.id);
        
      });

      
      test("deve alterar um spot", () async {
        await fakeFirestore.collection("spots")
          .doc("1")
          .set(testPico.toJson());

        var newPico = testPico
          .copyWith(
            picoName: "Pico Maneiro", 
            description: "Teste descrição alterada");
        
        await dataSource.update(MapperDtoPicomodel.toDto(newPico));

        
        final dadosAlterados = await dataSource.getbyID("1");
        expect(dadosAlterados.data, newPico.toJson());
        expect(dadosAlterados.id, equals('1') );

      });

      test("deve deletar um spot", () async {
        
        await fakeFirestore.collection("spots").doc("1").set(testPico.toJson());
        

        await dataSource.delete("1");
        
        final snapshot = await fakeFirestore.collection("spots").doc("1").get();

        expect(snapshot.exists, isFalse); //pico não existe
      });

      test("deve testar se a stream de spots emite lista de spots", () async {
        

        //criando falsos picos no bd falso
        await dataSource.create(MapperDtoPicomodel.toDto(testPico));
        await dataSource.create(MapperDtoPicomodel.toDto(testPico2));

        final stream = dataSource.load();

        expectLater(
          stream,
          emitsInOrder([
            isA<List<PicoFirebaseDTO>>()
                .having((list) => list.length, "deve ter 2 instancia", equals(2)),
            isA<List<PicoFirebaseDTO>>()
                .having((list) => list.length, "deve ter 3 instancia", equals(3)),
            // Após adicionar o pico
          ]),
        );

        await dataSource.create(MapperDtoPicomodel.toDto(testPico3));
      });
    });
  }
