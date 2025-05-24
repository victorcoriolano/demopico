import 'package:demopico/features/profile/infra/datasource/firebase_profile_update_datasource.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks/mocks_profile.dart';

class MockFirebaseProfileUpdateService extends Mock
    implements FirebaseProfileUpdateDatasource {}

void main() {
  group('Teste update profile data', () {
    late MockFirebaseProfileUpdateService fakeFirebaseProfileUpdateDatasource;

    setUp(() async {
      fakeFirebaseProfileUpdateDatasource = MockFirebaseProfileUpdateService();
    });

    test('Este teste deve subir uma nova bio', () async {
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;
      String novaBio = 'teste';
      datasourceUpdate.updateBio(novaBio, testeProfileCerto.id!);
    });

    test('Este teste deve adicionar um novo seguidor ', () async {
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;
      datasourceUpdate.updateFollowers(testeProfileCerto.id!);
    });

    test('Este teste deve adicionar uma nova contribuição ', () async {
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;
      datasourceUpdate.updateContributions(testeProfileCerto.id!);
    });

    test('Este teste deve subir ', () async {
      final datasourceUpdate = fakeFirebaseProfileUpdateDatasource;
      String newImage = 'certo';

      datasourceUpdate.updatePhoto(newImage, testeProfileCerto.id!);
    });
  });
}
