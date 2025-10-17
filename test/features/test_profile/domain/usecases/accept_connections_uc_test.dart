
import 'package:demopico/features/profile/domain/models/profile_result.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/domain/usecases/accept_connection_uc.dart';
import 'package:demopico/features/profile/infra/repository/chat_repository.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks/mocks_connections.dart';
import '../../../mocks/mocks_profiles.dart';

class NetworkRepositoryMock extends Mock implements NetworkRepository {}
class ProfileRepositoryMock extends Mock implements ProfileRepositoryImpl {}
class ChatRepositoryMock extends Mock implements ChatRepository {}


void main() {

  group("Deve testar o caso de uso de pegar as sugestões de usuários", () {
    late NetworkRepositoryMock repository;
    late AcceptConnectionUc useCase;
    late ProfileRepositoryMock profileRepoMock;
    late ChatRepositoryMock chatRepository;

    setUp(() {
      repository = NetworkRepositoryMock();
      profileRepoMock = ProfileRepositoryMock();
      chatRepository = ChatRepositoryMock();
      useCase = AcceptConnectionUc(networkRepository: repository, profileRepository: profileRepoMock, messageRepository: chatRepository);

      registerFallbackValue(dummyConnections[2]);
    });



    test("Deve retornar uma lista de todos os usuários exeto o user se o user não tiver conexões", () async {
      when(() => repository.updateRelationship(any()))
          .thenAnswer((_) async => dummyConnections[2]);
      when(() => profileRepoMock.getProfileByUser("addressedId2")).thenAnswer((_) async => ProfileResult.success(profile: mockProfileCompleto));
      when(() => profileRepoMock.getProfileByUser("userID2")).thenAnswer((_) async => ProfileResult.success(profile: mockProfileCompleto));
      when(() => profileRepoMock.updateProfile(mockProfileCompleto)).thenAnswer((_) async => ProfileResult.success(profile: mockProfileCompleto));
      when(() => profileRepoMock.updateProfile(mockProfileCompleto)).thenAnswer((_) async => ProfileResult.success(profile: mockProfileCompleto));

      final connectionAccepted = dummyConnections[2];
      final accept = await useCase.execute(connectionAccepted);

      expect(accept, isNotNull);
      expect(accept, isA<Relationship>());
      expect(accept.id, equals(connectionAccepted.id));
      expect(accept.status, equals(RequestConnectionStatus.accepted));

      verify(() => repository.updateRelationship(any())).called(1);
    });

   });

}