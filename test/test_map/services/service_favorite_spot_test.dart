import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_favorite_spot_service.dart';
import 'package:demopico/features/mapa/data/dtos/firebase_dto.dart';
import 'package:demopico/features/mapa/data/mappers/mapper_pico_favorito_firebase.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group("Deve testar o serviço de salvar spot", () {
    late FakeFirebaseFirestore fakeFirestore;
    late FirebaseFavoriteSpotRemoteDataSource dataSource;

    setUpAll(() async {
      fakeFirestore = FakeFirebaseFirestore();
      dataSource = FirebaseFavoriteSpotRemoteDataSource(firebaseFirestore: fakeFirestore);
    });

    test("Deve salvar um spot dos favoritos", () async {
      //criando um spot fake pra referenciar no pico favorito

      final result =
          await dataSource.saveSpot(FirebaseDTO(id: "id", data: {"idPico": "1", "idUser": "1"}));

      expect(result.data["idPico"], "1");
      expect(result, isA<FirebaseDTO>());

      final savedData = await fakeFirestore
          .collection("picosFavoritados")
          .get()
          .then((docs) => docs.docs.first.data());
      expect(savedData['idUser'], "1");
      expect(savedData['spotRef'], isA<DocumentReference>());
    });

    test("Deve retornar um lista de spot salvo", () async {
      String idUser = "1";
      Future.wait([
        dataSource.saveSpot(MapperFavoriteSpotFirebase.toDto(PicoFavorito(idPico: "1", idUsuario: idUser))),
        dataSource.saveSpot(MapperFavoriteSpotFirebase.toDto(PicoFavorito(idPico: "2", idUsuario: idUser))),
      ]);
      

      final result = await dataSource.listFavoriteSpot(idUser);

      expect(result, isA<List<FirebaseDTO>>());
      expect(result.length, equals(3));
    });

    test("Deve deletar um spot salvo", () async {

      final ref = await fakeFirestore.collection("spots").add({"spotRef": "1", "idUser": "1"});      
      final ref2 = await fakeFirestore.collection("spots").add({"spotRef": "1", "idUser": "1"});
      Future.wait([
        fakeFirestore.collection("picosFavoritados").add({"spotRef": ref, "idUser": "2"}),
        fakeFirestore.collection("picosFavoritados").add({"spotRef": ref2, "idUser": "2"}),
      ]);
      
      final resultBeforeDelete = await dataSource.listFavoriteSpot("2");

      expect(resultBeforeDelete[0].data["idPico"], equals(ref.id));
      expect(resultBeforeDelete.length, equals(2));
      await dataSource.removeFavorito(resultBeforeDelete[0].id); // removendo o primeiro item da lista

      final resultAfterDelete = await dataSource.listFavoriteSpot("2");
      expect(resultAfterDelete[0].data["idPico"], equals(ref2.id));
    });
  });
}
