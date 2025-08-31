import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/presentation/view_objects/suggestion_profile.dart';
import 'package:demopico/features/user/domain/interfaces/i_users_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/domain/usecases/get_sugestions_user_uc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks/mocks_profile.dart';

class UsersRepositoryMock extends Mock implements IUsersRepository {}
class NetworkRepositoryMock extends Mock implements INetworkRepository {}

void main() {

  group("Deve testar o caso de uso de pegar as sugestões de usuários", () {
    late UsersRepositoryMock repository;
    late GetSugestionsUserUc useCase;
    late NetworkRepositoryMock networkRepository;

    setUp(() {
      repository = UsersRepositoryMock();
            networkRepository = NetworkRepositoryMock();
      useCase = GetSugestionsUserUc(repository: repository, networkRepository: networkRepository);

    });

    test("Deve retornar uma lista de todos os usuários exeto o user se o user não tiver conexões", () async {
      when(() => repository.getSuggestionsProfileExcept(any()))
          .thenAnswer((_) async => [mockUserProfile2, testeProfileErrado]);

      final userTest = listUsers.first;

      final result = await useCase.execute(userTest.id);

      expect(result.isEmpty, false);
      expect(result.contains(SuggestionProfile.fromUser(userTest)), false);
      expect(result, isA<List<UserM>>());
    });

    test("deve retornar uma lista conexões que não contenha nem as conexões nem o user", () async {
      when(() => repository.getSuggestionsExceptConnections(any()))
          .thenAnswer((_) async => [mockUserProfile, testeProfileErrado]);

      final userTest = listUsers[1];

      final result = await useCase.execute(userTest.id);

      expect(result.isEmpty, false);
      expect(result.contains(SuggestionProfile.fromUser(userTest)), false);
      expect(result, isA<List<UserM>>());
    });

  });

}