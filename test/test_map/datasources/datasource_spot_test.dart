
  import 'package:demopico/features/mapa/data/data_sources/remote/firebase_spot_remote_datasource.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_spots_service.dart';
  import 'package:demopico/features/mapa/domain/models/pico_model.dart';
  import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
  import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

  import '../../mocks/mocks_spots.dart';

  void main() {
    group("deve testar o datasource de spots do cloud firestore", () {

      late FakeFirebaseFirestore fakeFirestore;
      late FirebaseSpotRemoteDataSource dataSource;

      setUp(() {
        fakeFirestore = FakeFirebaseFirestore();
        dataSource = FirebaseSpotRemoteDataSource(fakeFirestore);
      });

      test("dever criar um spot no datasource e retornar o id do documento", () async {
        

        final result = await dataSource.create(testPico3.toJson());

        expect(result, isA<String>());
        
      });

      
      test("deve alterar um spot", () async {
        await fakeFirestore.collection("spots")
          .doc("1")
          .set(testPico.toJson());

        var newPico = testPico
          .copyWith(
            picoName: "Pico Maneiro", 
            description: "Teste descrição alterada")
          .toJson();
        
        await dataSource.update(newPico);

        verify(() => fakeFirestore.collection("spots").doc("1").set(newPico)).called(1);
        

      });

      test("deve deletar um spot", () async {
        var fake = FakeFirebaseFirestore();
        var service = FirebaseSpotsService(firebaseFirestore: fake);

        final picoRef = await service.createSpot(testPico);

        expect(picoRef.id, isNotEmpty); //pico existe

        await service.deleteSpot(picoRef.id);
        
        final snapshot = await fake.collection('spots').doc(picoRef.id).get();

        expect(snapshot.exists, isFalse); //pico não existe
      });

      test("deve testar se a stream de spots emite lista de spots", () async {
        final fakeFiresore = FakeFirebaseFirestore();

        final service = FirebaseSpotsService(firebaseFirestore: fakeFiresore);

        //criando falsos picos no bd falso
        await service.createSpot(testPico);
        await service.createSpot(testPico2);

        final stream = service.loadSpots();

        expectLater(
          stream,
          emitsInOrder([
            isA<List<PicoModel>>()
                .having((list) => list.length, "deve ter 2 instancia", equals(2)),
            isA<List<PicoModel>>()
                .having((list) => list.length, "deve ter 3 instancia", equals(3)),
            // Após adicionar o pico
          ]),
        );
        await service.createSpot(testPico3);
      });
    });
  }
