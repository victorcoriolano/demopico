import 'package:demopico/features/profile/infra/datasource/firebase_profile_update_datasource.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/mocks_profile.dart';

class MockProfileFirebaseUpdateService extends Mock
    implements ProfileFirebaseUpdateService {}

void main() {
  group('Teste update profile data', () {
    late MockProfileFirebaseUpdateService fakeProfileFirebaseUpdateService;

    setUp(() async {
      fakeProfileFirebaseUpdateService = MockProfileFirebaseUpdateService();
    });

    test('Este teste deve subir uma nova bio', () async {
      final serviceUpdate = fakeProfileFirebaseUpdateService;
      String novaBio = 'teste';
      serviceUpdate.atualizarBio(novaBio, testeProfileCerto.id!);
    });

    test('Este teste deve adicionar um novo seguidor ', () async {
      final serviceUpdate = fakeProfileFirebaseUpdateService;
      serviceUpdate.atualizarSeguidores(testeProfileCerto.id!);
    });

    test('Este teste deve adicionar uma nova contribuição ', () async {
      final serviceUpdate = fakeProfileFirebaseUpdateService;
      serviceUpdate.atualizarContribuicoes(testeProfileCerto.id!);
    });

    test('Este teste deve subir ', () async {
      final serviceUpdate = fakeProfileFirebaseUpdateService;
      String newImage = 'certo';

      serviceUpdate.atualizarFoto(newImage, testeProfileCerto.id!);
    });
  });
}
