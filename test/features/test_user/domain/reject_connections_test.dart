import 'package:demopico/features/profile/domain/usecases/reject_connection_uc.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks/mocks_connections.dart';

class NetworkRepositoryMock extends Mock implements NetworkRepository {}

void main() {

  group("Deve testar o caso de uso de pegar as sugestões de usuários", () {
    late NetworkRepositoryMock repository;
    late RejectConnectionUc useCase;

    setUp(() {
      repository = NetworkRepositoryMock();
      useCase = RejectConnectionUc(networkRepository: repository);

      registerFallbackValue(dummyConnections.last);
    });



    test("Deve retornar uma lista de todos os usuários exeto o user se o user não tiver conexões", () async {
      when(() => repository.disconnectUser(any()))
          .thenAnswer((_) async => {});

      final connectionRejected = dummyConnections.last;
      await useCase.execute(connectionRejected);

      verify(() => repository.disconnectUser(any())).called(1);
    });

  });

}