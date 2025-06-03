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
      fakePersistContributionsUc.set(testeProfileCerto);
      verify(() => fakeRepositoryUpdate.updateContributions(testeProfileCerto)).called(1);
    });

    test('Deve retornar número de contribuições', () async {
      when(() => fakeRepositoryRead.getContributions(testeProfileCerto))
          .thenAnswer((_) async => testeProfileCerto.picosAdicionados!);

      final result = await fakePersistContributionsUc.get(testeProfileCerto);
      expect(result, testeProfileCerto.picosAdicionados);
      verify(() => fakeRepositoryRead.getContributions(testeProfileCerto)).called(1);
    });
  });
}
