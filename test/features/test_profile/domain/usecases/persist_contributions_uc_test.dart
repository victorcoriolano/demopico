import 'package:demopico/features/profile/domain/usecases/persist_contributions_uc.dart';
import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_profile.dart';

class RepositoryRead extends Mock implements ProfileReadRepository {}

class RepositoryUpdate extends Mock implements ProfileUpdateRepository {}

void main() {
  group('Testa contribuições do usuário', () {
    late RepositoryRead fakeRepositoryRead;
    late RepositoryUpdate fakeRepositoryUpdate;
    late PersistContributionsUc fakePersistContributionsUc;

    setUp(() {
      fakeRepositoryRead = RepositoryRead();
      fakeRepositoryUpdate = RepositoryUpdate();

      fakePersistContributionsUc = PersistContributionsUc(
        profileReadRepositoryIMP: fakeRepositoryRead,
        profileUpdateRepositoryIMP: fakeRepositoryUpdate,
      );
    });

    test('Deve chamar updateContributions sem dados explícitos', () async {
      fakePersistContributionsUc.set(mockUserProfile);
      verify(() => fakeRepositoryUpdate.updateContributions(mockUserProfile)).called(1);
    });

    test('Deve retornar número de contribuições', () async {
      when(() => fakeRepositoryRead.getContributions(mockUserProfile))
          .thenAnswer((_) async => mockUserProfile.picosAdicionados);

      final result = await fakePersistContributionsUc.get(mockUserProfile);
      expect(result, mockUserProfile.picosAdicionados);
      verify(() => fakeRepositoryRead.getContributions(mockUserProfile)).called(1);
    });
  });
}
