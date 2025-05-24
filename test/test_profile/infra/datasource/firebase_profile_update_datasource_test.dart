import 'package:demopico/features/profile/infra/datasource/firebase_profile_update_datasource.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../mocks/mocks_profile.dart';

void main() {
  group('Teste update profile data', () {
    late FirebaseProfileUpdateDatasource fakeFirebaseProfileUpdateDatasource;
    late FakeFirebaseFirestore fakeFirebaseFirestore;

    setUp(() async {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      await fakeFirebaseFirestore
          .collection("users")
          .doc(testeProfileCerto.id)
          .set(testeProfileCerto.toJsonMap());

      fakeFirebaseProfileUpdateDatasource =
          FirebaseProfileUpdateDatasource(firestore: fakeFirebaseFirestore);
    });

    test('Este teste deve subir uma nova bio', () async {
      String novaBio = 'teste';

      fakeFirebaseProfileUpdateDatasource.updateBio(
          novaBio, testeProfileCerto.id!);

      final referenceGet = await fakeFirebaseFirestore
          .collection("users")
          .doc(testeProfileCerto.id)
          .get();

      final result = referenceGet.data()!["description"];

      expect(result, novaBio);
    });

    test('Este teste deve adicionar um novo seguidor ', () async {
      fakeFirebaseProfileUpdateDatasource
          .updateFollowers(testeProfileCerto.id!);

          
      final referenceGet = await fakeFirebaseFirestore
          .collection("users")
          .doc(testeProfileCerto.id)
          .get();

      final result = referenceGet.data()!["conexoes"];

      expect(result, 1);
    });

    test('Este teste deve adicionar uma nova contribuição ', () async {
      fakeFirebaseProfileUpdateDatasource
          .updateContributions(testeProfileCerto.id!);

          
      final referenceGet = await fakeFirebaseFirestore
          .collection("users")
          .doc(testeProfileCerto.id)
          .get();

      final result = referenceGet.data()!["picosAdicionados"];

      expect(result, 1);
    });

    test('Este teste deve subir uma nova foto ', () async {
      String newImage = 'foto.jpg';

      fakeFirebaseProfileUpdateDatasource.updatePhoto(
          newImage, testeProfileCerto.id!);
        
        final referenceGet = await fakeFirebaseFirestore
          .collection("users")
          .doc(testeProfileCerto.id)
          .get();

      final result = referenceGet.data()!["pictureUrl"];
      expect(result, newImage);
    });
  });
}
