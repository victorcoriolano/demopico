import 'package:demopico/core/common/mappers/i_mapper_dto.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_network_datasource.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_connections.dart';
import '../../../mocks/mocks_users.dart';



// Mock class for any external services, like a Firebase or HTTP client
class MockNetworkService extends Mock implements FirebaseNetworkDatasource {}

void main() {
  late NetworkRepository repository;
  late MockNetworkService mockNetworkService;
  late IMapperDto mapper;
  late IMapperDto mapperConnection;


  setUpAll(() {
        mockNetworkService = MockNetworkService();
    // Initialize the repository with the mock service
    repository = NetworkRepository(datasource: mockNetworkService);
    mapper = repository.mapperUser;
    mapperConnection = repository.mapperConnection;
    // Register the mapper for UserM and Connection
    registerFallbackValue(mockUserProfile);
    registerFallbackValue(mockUserProfile2);
    registerFallbackValue(mapperConnection.toDTO(dummyConnections[0]));
  });

  group('getConnections', () {
    test('deve retornar uma lista de relacionamentos requisitados', () async {
      // Arrange
      when(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: any(), fieldOther: "status", valorDoStatus: RequestConnectionStatus.pending.name))
          .thenAnswer((_) async => Future.value([
            mapperConnection.toDTO(dummyConnections[1]),
            mapperConnection.toDTO(dummyConnections[2])
          ]));

      // Act
      final result = await repository.getRelationshipRequests("userID");

      // Assert
      expect(result, isA<List<Relationship>>());
      expect(result, isNotEmpty);
      expect(result.length, 2);
      verify(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: any(), fieldOther: "status", valorDoStatus: RequestConnectionStatus.pending.name)).called(1);
    });

    test("dever retornar uma lista de relacionamentos pendentes que o user enviou", () async {
      // Arrange
      when(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: "userID", fieldOther: "status", valorDoStatus: RequestConnectionStatus.pending.name))
          .thenAnswer((_) async => [
            mapperConnection.toDTO(dummyConnections[0]),
            mapperConnection.toDTO(dummyConnections[1])
          ]);

      // Act
      final result = await repository.getRelationshipRequests("userID");

      // Assert
      expect(result, isA<List<Relationship>>());
      expect(result, isNotEmpty);
      expect(result.length, 2);
    });

    test('should return a list of relationships accepted', () async {
      // Arrange
      when(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: "userID", fieldOther: "status", valorDoStatus: RequestConnectionStatus.accepted.name))
          .thenAnswer((_) async => [
            mapper.toDTO(mockUserProfile),
            mapper.toDTO(mockUserProfile2)
          ]);

      // Act
      final result = await repository.getRelationshipAccepted("userID");

      // Assert
      expect(result, isA<List<Relationship>>());
      expect(result, isNotEmpty);
      expect(result.length, 1);
      verify(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: "userID", fieldOther: "status", valorDoStatus: RequestConnectionStatus.accepted.name)).called(1);
    });
  });
  
  
  group('connectUser', () {


    test('should complete successfully when connecting two valid users', () async {
      // Arrange
      when(() => mockNetworkService.createConnection(any())).thenAnswer((_) async => Future.value(mapperConnection.toDTO(dummyConnections[0])));

      // Act
      final output = await repository.createRelationship(dummyConnections[0]);

      expect(output, isNotNull);
      expect(output.id, isNotEmpty);
      expect(output.requesterUser.id, equals(dummyConnections[0].requesterUser.id));
      expect(output.addressed.id, equals(dummyConnections[0].addressed.id));
    });

    test('should throw an exception if users are already connected', () async {
      // Arrange
      when(() => mockNetworkService.createConnection(any())).thenThrow(Exception('Already connected'));

      // Act & Assert
      expect(() => repository.createRelationship(dummyConnections[0]), throwsA(isA<Exception>()));    });
  });
  
  
  
  group('disconnectUser', () {
    // TODO CORRIGIR ESSES TESTES 
    test('should complete successfully when disconnecting two connected users', () async {
      // Arrange
      when(() => mockNetworkService.deleteConnection(mapperConnection.toDTO(dummyConnections[0]))).thenAnswer((_) async => {});

      // Act
      await repository.deleteRelationship(dummyConnections[0]);

      verify(() => mockNetworkService.deleteConnection(mapperConnection.toDTO(dummyConnections[0]))).called(1);
    });

    
  });
  
  group('updateRelationship', () {
    test('should update the relationship status successfully', () async {
      // Arrange
      final updatedConnection = dummyConnections[0].copyWith(status: RequestConnectionStatus.accepted);
      when(() => mockNetworkService.updateConnection(any())).thenAnswer((_) async => Future.value(mapperConnection.toDTO(updatedConnection)));

      // Act
      final result = await repository.updateRelationship(updatedConnection);

      // Assert
      expect(result, isA<Relationship>());
      expect(result.status, equals(RequestConnectionStatus.accepted));
      verify(() => mockNetworkService.updateConnection(any())).called(1);
    });

    test('should throw an exception if the update fails', () async {
      // Arrange
      when(() => mockNetworkService.updateConnection(any())).thenThrow(Exception('Update failed'));

      // Act & Assert
      expect(() => repository.updateRelationship(dummyConnections[0]), throwsA(isA<Exception>()));
    });
  });
}


