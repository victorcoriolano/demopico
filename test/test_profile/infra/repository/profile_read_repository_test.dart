import 'package:demopico/features/profile/domain/interfaces/i_profile_read_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_update_datasource.dart';
import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_profile.dart';

class MockDatasource extends Mock
    implements IProfileReadDatasource {}

void main() {
  group("Este group possui todas as operações de read do Profile", () {
    late MockDatasource fakeProfileReadRepository;
    setUp(() async {
      fakeProfileReadRepository = ProfileReadRepository.getInstance;
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
