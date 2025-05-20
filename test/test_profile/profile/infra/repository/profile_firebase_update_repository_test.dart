import 'package:demopico/features/profile/infra/repository/profile_firebase_update_repository.dart';
import 'package:demopico/features/profile/infra/service/profile_firebase_update_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/mocks_profile.dart';

void main() {
  group('Teste update profile data repository', () {
    late FakeFirebaseFirestore fakeFirestore;
    setUp(() async {
      fakeFirestore = FakeFirebaseFirestore();

      //criando um spot fake pra referenciar no pico favorito
      await fakeFirestore
          .collection("users")
          .doc(testeProfileCerto.id)
          .set(testeProfileCerto.toJsonMap());
    });

    test('Este teste deve subir uma nova bio', () async {
      final repositoryUpdate = ProfileFirebaseUpdateRepository(
          profileDatabaseUpdateServiceIMP:
              ProfileFirebaseUpdateService(firestore: fakeFirestore));

      String novaBio = 'teste';
      repositoryUpdate.atualizarBio(novaBio, testeProfileCerto);
    });

    test('Este teste deve adicionar um novo seguidor ', () async {
      final repositoryUpdate = ProfileFirebaseUpdateRepository(
          profileDatabaseUpdateServiceIMP:
              ProfileFirebaseUpdateService(firestore: fakeFirestore));
      repositoryUpdate.atualizarSeguidores(testeProfileCerto);
    });

    test('Este teste deve adicionar uma nova contribuição ', () async {
      final repositoryUpdate = ProfileFirebaseUpdateRepository(
          profileDatabaseUpdateServiceIMP:
              ProfileFirebaseUpdateService(firestore: fakeFirestore));
      repositoryUpdate.atualizarContribuicoes(testeProfileCerto);
    });

    test('Este teste deve subir uma nova image ', () async {
      final repositoryUpdate = ProfileFirebaseUpdateRepository(
          profileDatabaseUpdateServiceIMP:
              ProfileFirebaseUpdateService(firestore: fakeFirestore));
      String newImage = 'certo';

      repositoryUpdate.atualizarFoto(newImage, testeProfileCerto);
    });
  });
}
