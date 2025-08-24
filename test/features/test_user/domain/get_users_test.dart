import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/domain/usecases/get_sugestions_user_uc.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks/mocks_profile.dart';

class UserDataRepositoryMock extends Mock implements UserDataRepositoryImpl {}

void main() {

  group("Deve testar o caso de uso de pegar as sugestões de usuários", () {
    late UserDataRepositoryMock repository;
    late GetSugestionsUserUc useCase;

    setUp(() {
      repository = UserDataRepositoryMock();
      useCase = GetSugestionsUserUc(repository: repository);
    });

    test("Deve retornar uma lista de todos os usuários exeto o user se o user não tiver conexões", () async {
      when(() => repository.getUsers())
          .thenAnswer((_) async => listUsers);

      final userTest = listUsers.first;

      final result = await useCase.execute(userTest);

      expect(result.isEmpty, false);
      expect(result.contains(userTest), false);
      expect(result, isA<List<UserM>>());
    });

  });

}