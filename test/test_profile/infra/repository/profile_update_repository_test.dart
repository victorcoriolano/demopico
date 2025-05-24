import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_profile.dart';

class MockProfileUpdateRepository extends Mock
    implements ProfileUpdateRepository {}

void main() {
  group('Teste update profile data repository', () {
    late MockProfileUpdateRepository fakeProfileUpdateRepository;

    setUp(() async {
      fakeProfileUpdateRepository = MockProfileUpdateRepository();
    });

    test('Este teste deve subir uma nova bio', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      String novaBio = 'teste';
      repositoryUpdate.updateBio(novaBio, testeProfileCerto);
    });

    test('Este teste deve adicionar um novo seguidor ', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      repositoryUpdate.updateFollowers(testeProfileCerto);
    });

    test('Este teste deve adicionar uma nova contribuição ', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      repositoryUpdate.updateContributions(testeProfileCerto);
    });

    test('Este teste deve subir uma nova image ', () async {
      final repositoryUpdate = fakeProfileUpdateRepository;
      String newImage = 'certo';
      repositoryUpdate.updatePhoto(newImage, testeProfileCerto);
    });
  });
}
