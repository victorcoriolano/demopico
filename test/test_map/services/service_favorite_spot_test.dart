import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/services/firebase_favorite_spot_service.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/models/pico_favorito_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../use_cases/create_spot_uc_test.dart';
void main() {
  group("Deve testar o serviço de salvar spot", (){
    late FakeFirebaseFirestore fakeFirestore;
    setUp(()async {
      fakeFirestore = FakeFirebaseFirestore();
      //criando um spot fake pra referenciar no pico favorito
    
    });

    test("Deve salvar um spot dos favoritos", () async {
      final service =  FirebaseFavoriteSpotService(fakeFirestore);
      //criando um spot fake pra referenciar no pico favorito
      await fakeFirestore.collection("spots").doc(testPico.id).set(testPico.toJson());
      
      final result = await service.saveSpot(PicoFavorito(idPico: "1", idUsuario: "1"));
      
      
      expect(result.idPico, "1");
      expect(result, isA<PicoFavoritoModel>());

      final savedData = await fakeFirestore.collection("picosFavoritados").get().then((docs) => docs.docs.first.data());
      expect(savedData['idUsuario'], "1");
      expect(savedData['idPico'] , isA<DocumentReference>()); 
    });
    test("Deve retornar um lista de spot salvo", (){});
    test("Deve deletar um spot salvo", (){});
    test("Deve retornar limpar a lista de spots", (){});
  });
}