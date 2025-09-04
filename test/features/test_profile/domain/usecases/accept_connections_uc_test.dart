
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/domain/usecases/accept_connection_uc.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks/mocks_connections.dart';

class NetworkRepositoryMock extends Mock implements NetworkRepository {}

void main() {

  group("Deve testar o caso de uso de pegar as sugestões de usuários", () {
    late NetworkRepositoryMock repository;
    late AcceptConnectionUc useCase;

    setUp(() {
      repository = NetworkRepositoryMock();
      useCase = AcceptConnectionUc(networkRepository: repository);

      registerFallbackValue(dummyConnections[2]);
    });



    test("Deve retornar uma lista de todos os usuários exeto o user se o user não tiver conexões", () async {
      when(() => repository.updateConnection(any()))
          .thenAnswer((_) async => dummyConnections[2]);

      final connectionAccepted = dummyConnections[2];
      final accept = await useCase.execute(connectionAccepted);

      expect(accept, isNotNull);
      expect(accept, isA<Relationship>());
      expect(accept.id, equals(connectionAccepted.id));
      expect(accept.status, equals(RequestConnectionStatus.accepted));

      verify(() => repository.updateConnection(any())).called(1);
    });

  });

}