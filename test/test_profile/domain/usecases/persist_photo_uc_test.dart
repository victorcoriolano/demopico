import 'package:demopico/features/profile/domain/usecases/persist_photo_uc.dart';
import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_profile.dart';

class RepositoryRead extends Mock implements ProfileReadRepository {}

class RepositoryUpdate extends Mock implements ProfileUpdateRepository {}

void main() {
  group('Este teste deve conseguir manter uma foto de perfil', () {
    late RepositoryRead fakeRepositoryRead;
    late RepositoryUpdate fakeRepositoryUpdate;
    late PersistPhotoUc fakePersistPhotoUc;

    setUp(() async {
      fakeRepositoryUpdate = RepositoryUpdate();
      fakeRepositoryRead = RepositoryRead();

      fakePersistPhotoUc = PersistPhotoUc(
        profileReadRepositoryIMP: fakeRepositoryRead,
        profileUpdateRepositoryIMP: fakeRepositoryUpdate,
      );
    });

    test('Este teste deve validar os dados antes de mandar para infra',
        () async {
      String novaFoto = "https://example.com/foto.png";
      fakePersistPhotoUc.set(novaFoto, mockUserProfile);
      verify(() => fakeRepositoryUpdate.updatePhoto(novaFoto, mockUserProfile))
          .called(1);
    });

    test('Este teste deve retornar uma foto atualizada', () async {
      when(() => fakeRepositoryRead.getPhoto(mockUserProfile))
          .thenAnswer((_) async => mockUserProfile.pictureUrl!);

      String foto = await fakePersistPhotoUc.get(mockUserProfile);
      expect(foto, mockUserProfile.pictureUrl);
      verify(() => fakeRepositoryRead.getPhoto(mockUserProfile)).called(1);
    });
  });
}
