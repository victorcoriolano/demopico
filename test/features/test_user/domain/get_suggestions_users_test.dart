import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/presentation/view_objects/suggestion_profile.dart';
import 'package:demopico/features/user/domain/interfaces/i_users_repository.dart';
import 'package:demopico/features/user/domain/usecases/get_sugestions_user_uc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks/mocks_connections.dart';
import '../../mocks/mocks_users.dart';

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
       when(() => networkRepository.getRelationshipRequests(any()))
          .thenAnswer((_) async => []);
      when(() => networkRepository.getRelationshipAccepted(any()))
          .thenAnswer((_) async => []);
      when(() => networkRepository.getRelationshipSent(any()))
          .thenAnswer((_) async => []);

      when(() => repository.findAll())
          .thenAnswer((_) async => listUsers);

      final userTest = listUsers[1];

      final result = await useCase.execute(userTest.id);

      expect(result.isEmpty, false);
      expect(result.contains(SuggestionProfile.fromUser(userTest)), false);
      expect(result, isA<List<SuggestionProfile>>());
    });

    test("deve retornar uma lista conexões que não contenha nem as conexões nem o user", () async {
      when(() => networkRepository.getRelationshipRequests(any()))
          .thenAnswer((_) async => []);
      when(() => networkRepository.getRelationshipAccepted(any()))
          .thenAnswer((_) async => [dummyConnections[0]]);
      when(() => networkRepository.getRelationshipSent(any()))
          .thenAnswer((_) async => []);

      when(() => repository.findAll())
          .thenAnswer((_) async => listUsers);

      final userTest = listUsers[1];

      final result = await useCase.execute(userTest.id);

      expect(result.isEmpty, false);
      expect(result.contains(SuggestionProfile.fromUser(userTest)), false);
      expect(result, isA<List<SuggestionProfile>>());
    });

  });

}