import 'package:demopico/features/profile/infra/repository/profile_firebase_read_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/mocks_profile.dart';

class MockProfileFirebaseReadRepository extends Mock
    implements ProfileFirebaseReadRepository {}

void main() {
  group("Este group possui todas as operações de read do Profile", () {
    late MockProfileFirebaseReadRepository fakeProfileFirebaseReadRepository;
    setUp(() async {
      fakeProfileFirebaseReadRepository = MockProfileFirebaseReadRepository();
    });

    test("Este teste deve retornar uma string de nova foto ", () async {
      final repositoryRead = fakeProfileFirebaseReadRepository;
      String text = await repositoryRead.pegarFoto(testeProfileCerto);
      expect(text, text);
    });

    test("Este teste deve retornar uma string de uma nova bio", () async {
      final repositoryRead = fakeProfileFirebaseReadRepository;

      String text = await repositoryRead.pegarBio(testeProfileCerto);
      expect(text, text);
    });

    test("Este teste deve retornar um novo int de seguidor", () async {
      final repositoryRead = fakeProfileFirebaseReadRepository;

      int text = await repositoryRead.pegarSeguidores(testeProfileCerto);
      expect(text, text);
    });

    test("Este teste deve retornar um novo int de contribuições", () async {
      final repositoryRead = fakeProfileFirebaseReadRepository;

      int text = await repositoryRead.pegarContribuicoes(testeProfileCerto);
      expect(text, text);
    });
  });
}
