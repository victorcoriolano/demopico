
import 'package:demopico/features/mapa/data/services/service_firebase_spots.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mocks_spots.dart';

void main(){
  group("deve testar o serviço de spots do firebase cloud firestore", (){
    test("dever criar um spot", () async {
      final fakeFiresore = FakeFirebaseFirestore();
      final service = ServiceFirebaseSpots(fakeFiresore);

      final result = await service.createSpot(testPico3);

      expect(result, isA<PicoModel?>());
      expect(result?.picoName, equals("Pico Dhora"));
      
    });
    test("deve deletar um spot", () {});
    test("deve retornar uma stream de todos os spots", () async {
      final fakeFiresore = FakeFirebaseFirestore();

      final service = ServiceFirebaseSpots(fakeFiresore);

      //criando falsos picos no bd falso 
      await service.createSpot(testPico);
      await service.createSpot(testPico2);
      await service.createSpot(testPico3);

      final query =  service.executeQuery();

    });
  });
}