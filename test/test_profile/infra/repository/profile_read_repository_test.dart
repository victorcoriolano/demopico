import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_profile.dart';

class MockUserRepository extends Mock implements IUserDatabaseRepository {}

void main() {
  group("Este group possui todas as operações de read do Profile", () {
    late MockUserRepository fakeUserRepository;
    late ProfileReadRepository fakeProfileReadRepository;

    setUp(() async {
      fakeUserRepository = MockUserRepository();
      fakeProfileReadRepository =
          ProfileReadRepository(userRepositoryIMP: fakeUserRepository);
    });

    test("Este teste deve retornar uma string de nova foto ", () async {
      when(() => fakeUserRepository.getUserDetails(testeProfileCerto.id!))
          .thenAnswer((_) async => testeProfileCerto);

      final result =
          await fakeProfileReadRepository.getPhoto(testeProfileCerto);

      expect(result, equals(testeProfileCerto.pictureUrl));

      verify(() => fakeUserRepository.getUserDetails(testeProfileCerto.id!))
          .called(1);
    });

    test("Este teste deve retornar uma string de uma nova bio", () async {
      when(() => fakeUserRepository.getUserDetails(testeProfileCerto.id!))
          .thenAnswer((_) async => testeProfileCerto);

      final result = await fakeProfileReadRepository.getBio(testeProfileCerto);

      expect(result, equals(testeProfileCerto.description));
      verify(() => fakeUserRepository.getUserDetails(testeProfileCerto.id!))
          .called(1);
    });

    test("Este teste deve retornar um novo int de seguidor", () async {
      when(() => fakeUserRepository.getUserDetails(testeProfileCerto.id!))
          .thenAnswer((_) async => testeProfileCerto);

      final result =
          await fakeProfileReadRepository.getFollowers(testeProfileCerto);

      expect(result, equals(testeProfileCerto.conexoes));
      verify(() => fakeUserRepository.getUserDetails(testeProfileCerto.id!))
          .called(1);
    });

    test("Este teste deve retornar um novo int de contribuições", () async {
      when(() => fakeUserRepository.getUserDetails(testeProfileCerto.id!))
          .thenAnswer((_) async => testeProfileCerto);

      final result =
          await fakeProfileReadRepository.getContributions(testeProfileCerto);

      expect(result, equals(testeProfileCerto.picosAdicionados));
      verify(() => fakeUserRepository.getUserDetails(testeProfileCerto.id!))
          .called(1);
    });
  });
}
