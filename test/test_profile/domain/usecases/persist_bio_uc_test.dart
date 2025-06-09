import 'package:demopico/features/profile/domain/usecases/persist_bio_uc.dart';
import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_profile.dart';

class RepositoryRead extends Mock implements ProfileReadRepository {}

class RepositoryUpdate extends Mock implements ProfileUpdateRepository {}

void main() {
  group('Este teste deve conseguir manter uma biografia', () {
    late RepositoryRead fakeRepositoryRead;
    late RepositoryUpdate fakeRepositoryUpdate;
    late PersistBioUc fakePersistBioUc;

    setUp(() async {
      fakeRepositoryUpdate = RepositoryUpdate();
      fakeRepositoryRead = RepositoryRead();

      fakePersistBioUc = PersistBioUc(
          profileReadRepositoryIMP: fakeRepositoryRead,
          profileUpdateRepositoryIMP: fakeRepositoryUpdate);
    });

    test('Este teste deve validar os dados antes de mandar para infra',
        () async {
      String novaBio = "newBio";
      fakePersistBioUc.set(novaBio, mockUserProfile);
      verify(() => fakeRepositoryUpdate.updateBio(novaBio, mockUserProfile))
          .called(1);
    });

    test('Este teste deve retornar uma bio atualizado', () async {
      when(() => fakeRepositoryRead.getBio(mockUserProfile))
          .thenAnswer((_) async => mockUserProfile.description!);

      String bio = await fakePersistBioUc.get(mockUserProfile);
      expect(bio, mockUserProfile.description);
      verify(() => fakeRepositoryRead.getBio(mockUserProfile)).called(1);
    });
  });
}
