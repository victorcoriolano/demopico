import 'package:demopico/features/profile/domain/usecases/persist_followers_uc.dart';
import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_profile.dart';

class RepositoryRead extends Mock implements ProfileReadRepository {}

class RepositoryUpdate extends Mock implements ProfileUpdateRepository {}

void main() {
  group('Testa seguidores do usuário', () {
    late RepositoryRead fakeRepositoryRead;
    late RepositoryUpdate fakeRepositoryUpdate;
    late PersistFollowersUc fakePersistFollowersUc;

    setUp(() {
      fakeRepositoryRead = RepositoryRead();
      fakeRepositoryUpdate = RepositoryUpdate();

      fakePersistFollowersUc = PersistFollowersUc(
        profileReadRepositoryIMP: fakeRepositoryRead,
        profileUpdateRepositoryIMP: fakeRepositoryUpdate,
      );
    });

    test('Deve chamar updateFollowers corretamente', () async {
      fakePersistFollowersUc.set(mockUserProfile);
      verify(() => fakeRepositoryUpdate.updateFollowers(mockUserProfile)).called(1);
    });

    test('Deve retornar número de seguidores', () async {
      when(() => fakeRepositoryRead.getFollowers(mockUserProfile))
          .thenAnswer((_) async => mockUserProfile.conexoes);

      final result = await fakePersistFollowersUc.get(mockUserProfile);
      expect(result, mockUserProfile.conexoes);
      verify(() => fakeRepositoryRead.getFollowers(mockUserProfile)).called(1);
    });
  });
}
