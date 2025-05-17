import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_favorite_spot_service.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/models/pico_favorito_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../use_cases/create_spot_uc_test.dart';

void main() {
  group("Deve testar o serviço de salvar spot", () {
    late FakeFirebaseFirestore fakeFirestore;
    setUp(() async {
      fakeFirestore = FakeFirebaseFirestore();
      //criando um spot fake pra referenciar no pico favorito
      await fakeFirestore
          .collection("spots")
          .doc(testPico.id)
          .set(testPico.toJson());
    });

    test("Deve salvar um spot dos favoritos", () async {
      final service = FirebaseFavoriteSpotService(firebaseFirestore: fakeFirestore);
      //criando um spot fake pra referenciar no pico favorito

      final result =
          await service.saveSpot(PicoFavorito(idPico: "1", idUsuario: "1"));

      expect(result.idPico, "1");
      expect(result, isA<PicoFavoritoModel>());

      final savedData = await fakeFirestore
          .collection("picosFavoritados")
          .get()
          .then((docs) => docs.docs.first.data());
      expect(savedData['idUsuario'], "1");
      expect(savedData['idPico'], isA<DocumentReference>());
    });

    test("Deve retornar um lista de spot salvo", () async {
      final service = FirebaseFavoriteSpotService(firebaseFirestore: fakeFirestore);
      String idUser = "1";
      await service.saveSpot(PicoFavorito(idPico: "1", idUsuario: "1"));
      await service.saveSpot(PicoFavorito(idPico: "2", idUsuario: "1"));

      final result = await service.listFavoriteSpot(idUser);

      expect(result, isA<List<PicoFavoritoModel>>());
      expect(result[1].idPico, equals("2"));
      expect(result.length, equals(2));
    });
    test("Deve deletar um spot salvo", () async {
      final service = FirebaseFavoriteSpotService(firebaseFirestore: fakeFirestore);
      String idUser = "1";
      String idPico = "1";
      final result = await service.saveSpot(PicoFavorito(idPico: idPico, idUsuario: idUser));
      final resultBeforeDelete = await service.listFavoriteSpot(idUser);

      expect(result.idUsuario, equals("1"));
      expect(resultBeforeDelete.length, equals(1));
      await service.deleteSave(result.id);

      final resultAfterDelete = await service.listFavoriteSpot(idUser);
      expect(resultAfterDelete.length, equals(0));
    });
  });
}
