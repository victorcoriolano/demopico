import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks_profile.dart';

class MockProfileFirebaseUpdateRepository extends Mock
    implements ProfileFirebaseUpdateRepository {}

void main() {
  group('Teste update profile data repository', () {
    late MockProfileFirebaseUpdateRepository
        fakeProfileFirebaseUpdateRepository;

    setUp(() async {
      fakeProfileFirebaseUpdateRepository =
          MockProfileFirebaseUpdateRepository();
    });

    test('Este teste deve subir uma nova bio', () async {
      final repositoryUpdate = fakeProfileFirebaseUpdateRepository;
      String novaBio = 'teste';
      repositoryUpdate.atualizarBio(novaBio, testeProfileCerto);
    });

    test('Este teste deve adicionar um novo seguidor ', () async {
      final repositoryUpdate = fakeProfileFirebaseUpdateRepository;
      repositoryUpdate.atualizarSeguidores(testeProfileCerto);
    });

    test('Este teste deve adicionar uma nova contribuição ', () async {
      final repositoryUpdate = fakeProfileFirebaseUpdateRepository;
      repositoryUpdate.atualizarContribuicoes(testeProfileCerto);
    });

    test('Este teste deve subir uma nova image ', () async {
      final repositoryUpdate = fakeProfileFirebaseUpdateRepository;
      String newImage = 'certo';
      repositoryUpdate.atualizarFoto(newImage, testeProfileCerto);
    });
  });
}
