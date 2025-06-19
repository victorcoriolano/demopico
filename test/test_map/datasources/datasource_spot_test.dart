
import 'package:demopico/core/common/data/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_spot_remote_datasource.dart';
import 'package:demopico/core/common/data/dtos/firebase_dto.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mocks_spots.dart';

  void main() {
    group("deve testar o datasource de spots do cloud firestore", () {

      late FakeFirebaseFirestore fakeFirestore;
      late FirebaseSpotRemoteDataSource dataSource;
      late IMapperDto mapper;

      setUpAll(() {
        fakeFirestore = FakeFirebaseFirestore();
        dataSource = FirebaseSpotRemoteDataSource(fakeFirestore);
        mapper = FirebaseDtoMapper<PicoModel>(
          fromJson: (data, id) => PicoModel.fromJson(data, id),
          toMap: (model) => model.toMap() ,
          getId: (model) => model.id,
        );
      });

      tearDown(() {
        fakeFirestore.clearPersistence();
      });

      test("dever criar um spot no datasource e retornar um dto com id", () async {

        final result = await dataSource.create(mapper.toDTO(testPico));

        expect(result, isA<FirebaseDTO>());
        expect(result.data, isA<Map<String, dynamic>>());
        expect(result.id, isA<String>());
        debugPrint(result.id);
        
      });

      
      test("deve alterar um spot", () async {
        await fakeFirestore.collection("spots")
          .doc("1")
          .set(testPico.toMap());

        var newPico = testPico
          .copyWith(
            picoName: "Pico Maneiro", 
            description: "Teste descrição alterada");
        
        await dataSource.update(mapper.toDTO(newPico));

        
        final dadosAlterados = await dataSource.getbyID("1");
        expect(dadosAlterados.data, newPico.toMap());
        expect(dadosAlterados.id, equals('1') );

      });

      test("deve deletar um spot", () async {
        
        await fakeFirestore.collection("spots").doc("1").set(testPico.toMap());
        

        await dataSource.delete("1");
        
        final snapshot = await fakeFirestore.collection("spots").doc("1").get();

        expect(snapshot.exists, isFalse); //pico não existe
      });

      test("deve testar se a stream de spots emite lista de spots", () async {
        

        //criando falsos picos no bd falso
        await Future.wait([
          fakeFirestore.collection("spots").doc("1").set(testPico.toMap()),
          fakeFirestore.collection("spots").doc("2").set(testPico2.toMap()),
        ]);

        final stream = dataSource.load();

        expectLater(
          stream,
          emitsInOrder([
            isA<List<FirebaseDTO>>()
                .having((list) => list.length, "deve ter 2 instancia", equals(2)),
            isA<List<FirebaseDTO>>()
                .having((list) => list.length, "deve ter 3 instancia", equals(3)),
            // Após adicionar o pico
          ]),
        );

        await dataSource.create(mapper.toDTO(testPico3));
      });
    });
  }
