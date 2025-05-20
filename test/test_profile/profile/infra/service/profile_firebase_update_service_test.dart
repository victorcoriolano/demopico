import 'package:demopico/features/profile/infra/service/profile_firebase_update_service.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/mocks_profile.dart';

class MockProfileFirebaseUpdateService extends Mock
    implements ProfileFirebaseUpdateService {}

class MockUserM extends Mock implements UserM {}

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
