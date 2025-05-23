import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/mocks_profile.dart';

class MockProfileFReadRepository extends Mock
    implements ProfileReadRepository {}

void main() {
  group("Este group possui todas as operações de read do Profile", () {
    late MockProfileFReadRepository fakeProfileReadRepository;
    setUp(() async {
      fakeProfileReadRepository = MockProfileFReadRepository();
    });

    test("Este teste deve retornar uma string de nova foto ", () async {
      final repositoryRead = fakeProfileReadRepository;
      String text = await repositoryRead.getPhoto(testeProfileCerto);
      expect(text, text);
    });

    test("Este teste deve retornar uma string de uma nova bio", () async {
      final repositoryRead = fakeProfileReadRepository;

      String text = await repositoryRead.getBio(testeProfileCerto);
      expect(text, text);
    });

    test("Este teste deve retornar um novo int de seguidor", () async {
      final repositoryRead = fakeProfileReadRepository;

      int text = await repositoryRead.getFollowers(testeProfileCerto);
      expect(text, text);
    });

    test("Este teste deve retornar um novo int de contribuições", () async {
      final repositoryRead = fakeProfileReadRepository;

      int text = await repositoryRead.getContributions(testeProfileCerto);
      expect(text, text);
    });
  });
}
