
  import 'package:demopico/features/mapa/data/services/firebase_spots_service.dart';
  import 'package:demopico/features/mapa/domain/models/pico_model.dart';
  import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
  import 'package:flutter_test/flutter_test.dart';

  import '../../mocks/mocks_spots.dart';

  void main() {
    group("deve testar o serviço de spots do firebase cloud firestore", () {

      test("dever criar um spot", () async {
        final fakeFiresore = FakeFirebaseFirestore();
        final service = FirebaseSpotsService(firebaseFirestore: fakeFiresore);

        final result = await service.createSpot(testPico3);

        expect(result, isA<PicoModel?>());
        expect(result?.picoName, equals("Pico Dhora"));
      });

      
      test("deve alterar um spot", () async {
        final fakeFirestore = FakeFirebaseFirestore();

        final service = FirebaseSpotsService(firebaseFirestore: fakeFirestore); 
        var pico = await service.createSpot(testPico);

        final result = await service.updateSpot(pico!.copyWith(nota: 5)); 

        expect(result.nota, equals(5)); 


      });

      test("deve deletar um spot", () async {
        var fake = FakeFirebaseFirestore();
        var service = FirebaseSpotsService(firebaseFirestore: fake);

        final picoRef = await service.createSpot(testPico);

        expect(picoRef?.id, isNotEmpty); //pico existe

        await service.deleteSpot(picoRef!.id);
        
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
