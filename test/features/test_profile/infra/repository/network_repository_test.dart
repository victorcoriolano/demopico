import 'package:demopico/core/common/files_manager/mappers/i_mapper_dto.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_network_datasource.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks_connections.dart';
import '../../../mocks/mocks_profile.dart';



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
    const String userID = 'user123';

    test('should return a list of relationships when relationships exist', () async {
      // Arrange
      when(() => mockNetworkService.getRelactionships( fieldRequest: any(), valueID: any(), fieldOther: any(), valorDoStatus: any()))
          .thenAnswer((_) async => [
            mapper.toDTO(mockUserProfile),
            mapper.toDTO(mockUserProfile2)
          ]);

      // Act
      final result = await repository.getRelationshipAccepted(userID);

      // Assert
      expect(result, isA<List<UserM>>());
      expect(result, isNotEmpty);
      expect(result.length, 2);
      verify(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: userID, fieldOther: "status", valorDoStatus: RequestConnectionStatus.accepted.name)).called(1);
    });

    test('should return an empty list when no connections exist', () async {
      // Arrange
      when(() => mockNetworkService.getRelactionships(fieldRequest: any(), valueID: any(), fieldOther: any(), valorDoStatus: any()))
          .thenAnswer((_) async => []);

      // Act
      final result = await repository.getRelationshipAccepted(userID);

      // Assert
      expect(result, isEmpty);
    });

    test('should throw an exception on a server error', () async {
      // Arrange
      when(() => mockNetworkService.getRelactionships(fieldRequest: any(),valueID: any(),fieldOther: any(), valorDoStatus: any()))
          .thenThrow(Exception('Server error'));

      // Act & Assert
      expect(() => repository.getRelationshipAccepted(userID), throwsA(isA<Exception>()));
      verify(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: userID, fieldOther: "status", valorDoStatus: RequestConnectionStatus.accepted.name)).called(1);
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
      when(() => mockNetworkService.deleteConnection(any())).thenAnswer((_) async => Future.value());

      // Act
      await repository.deleteRelationship(dummyConnections[0]);

      verify(() => mockNetworkService.deleteConnection(mapperConnection.toDTO(dummyConnections[0]))).called(1);
    });

    
  });
  
  
  
  group('getConnectionRequests', () {

    test('should return a list of connections when requests exist', () async {
      // Arrange
      when(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: any(), fieldOther: "status", valorDoStatus: RequestConnectionStatus.pending.name))
          .thenAnswer((_) async => Future.value([
            mapperConnection.toDTO(dummyConnections[1]),
            mapperConnection.toDTO(dummyConnections[2])
          ]));

      // Act
      final result = await repository.getRelationshipRequests(dummyConnections[0].addressed.id);

      // Assert
      expect(result, isA<List<Relationship>>());
      expect(result, isNotEmpty);
      expect(result.length, 2);
      verify(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: any(), fieldOther: "status", valorDoStatus: RequestConnectionStatus.pending.name)).called(1);
    });

    test('should return an empty list when no requests exist', () async {
      // Arrange
      when(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: any(), fieldOther: "status", valorDoStatus: RequestConnectionStatus.pending.name))
          .thenAnswer((_) async => []);

      // Act
      final result = await repository.getRelationshipRequests(dummyConnections[0].addressed.id);

      // Assert
      expect(result, isEmpty);
      verify(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: any(), fieldOther: "status", valorDoStatus: RequestConnectionStatus.pending.name)).called(1);
    });

    test('should throw an exception on a server error', () async {
      // Arrange
      when(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: any(), fieldOther: "status", valorDoStatus: RequestConnectionStatus.pending.name))
          .thenThrow(Exception('Server error'));

      // Act & Assert
      expect(() => repository.getRelationshipRequests(dummyConnections[0].addressed.id), throwsA(isA<Exception>()));
      verify(() => mockNetworkService.getRelactionships(fieldRequest: "requesterUserID", valueID: any(), fieldOther: "status", valorDoStatus: RequestConnectionStatus.pending.name)).called(1);
    });
  });
}


