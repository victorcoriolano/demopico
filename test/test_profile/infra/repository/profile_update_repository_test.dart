import 'package:demopico/features/profile/infra/datasource/firebase_profile_update_datasource.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
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
    setUp(() async {


      fakeFirebaseProfileUpdateDatasource =
          MockFirebaseProfileUpdateDatasource();

      fakeProfileUpdateRepository = ProfileUpdateRepository(
          databaseProfileUpdateServiceIMP: fakeFirebaseProfileUpdateDatasource);
    });

    test('Este teste deve passar uma bio e um id compativel com o do datasource', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;

      String novaBio = 'teste';

      repositoryUpdate.updateBio(novaBio, mockUserProfile);

      verify(() => datasourceUpdate.updateBio(novaBio, mockUserProfile.id))
          .called(1);
    });

    test('Este teste deve passar um id compativel com o do datasource', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;

      repositoryUpdate.updateFollowers(mockUserProfile);
      verify(() => datasourceUpdate.updateFollowers(mockUserProfile.id));
    });

    test('Este teste deve passar um id compativel com o do datasource', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;
      repositoryUpdate.updateContributions(mockUserProfile);
      verify(() => datasourceUpdate.updateContributions(mockUserProfile.id));
    });

    test('Este teste deve passar uma foto e um id compativel com o do datasource ', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;
      String novaImage = "newImage.jpg";

      repositoryUpdate.updatePhoto(novaImage, mockUserProfile);
      verify(
          () => datasourceUpdate.updatePhoto(novaImage, mockUserProfile.id));
    });
  });
}
