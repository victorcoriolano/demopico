import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_profile_update_datasource.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_profile.dart';

class MockFirebaseProfileUpdateDatasource extends Mock
    implements FirebaseProfileUpdateDatasource {}

void main() {
  group('Teste update profile data repository', () {
    late MockFirebaseProfileUpdateDatasource
        fakeFirebaseProfileUpdateDatasource;
    late ProfileUpdateRepository fakeProfileUpdateRepository;
    late FakeFirebaseFirestore fakeFirebaseFirestore;
    setUp(() async {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      await fakeFirebaseFirestore
          .collection("users")
          .doc(testeProfileCerto.id)
          .set(testeProfileCerto.toJsonMap());

      fakeFirebaseProfileUpdateDatasource =
          MockFirebaseProfileUpdateDatasource();

      fakeProfileUpdateRepository = ProfileUpdateRepository(
          databaseProfileUpdateServiceIMP: fakeFirebaseProfileUpdateDatasource);
    });

    test('Este teste deve passar uma bio e um id compativel com o do datasource', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;

      String novaBio = 'teste';

      repositoryUpdate.updateBio(novaBio, testeProfileCerto);

      verify(() => datasourceUpdate.updateBio(novaBio, testeProfileCerto.id!))
          .called(1);
    });

    test('Este teste deve passar um id compativel com o do datasource', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;

      repositoryUpdate.updateFollowers(testeProfileCerto);
      verify(() => datasourceUpdate.updateFollowers(testeProfileCerto.id!));
    });

    test('Este teste deve passar um id compativel com o do datasource', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;
      repositoryUpdate.updateContributions(testeProfileCerto);
      verify(() => datasourceUpdate.updateContributions(testeProfileCerto.id!));
    });

    test('Este teste deve passar uma foto e um id compativel com o do datasource ', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;
      String novaImage = "newImage.jpg";

      repositoryUpdate.updatePhoto(novaImage, testeProfileCerto);
      verify(
          () => datasourceUpdate.updatePhoto(novaImage, testeProfileCerto.id!));
    });
  });
}
