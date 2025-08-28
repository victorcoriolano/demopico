import 'package:demopico/features/profile/domain/usecases/get_connections_requests_uc.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks/mocks_connections.dart';

class NetworkRepositoryMock extends Mock implements NetworkRepository {}

void main() {

  group("Deve testar o caso de uso de pegar as sugestões de usuários", () {
    late NetworkRepositoryMock repository;
    late GetConnectionsRequestsUc useCase;

    setUp(() {
      repository = NetworkRepositoryMock();
      useCase = GetConnectionsRequestsUc(networkRepository: repository);

      registerFallbackValue(dummyConnections.last);
    });

    test("Deve retornar uma lista de todos os usuários exeto o user se o user não tiver conexões", () async {
      when(() => repository.getConnectionRequests(any()))
          .thenAnswer((_) async => dummyConnections);

      await useCase.execute("userId");

      verify(() => repository.getConnectionRequests(any())).called(1);
    });

  });

}