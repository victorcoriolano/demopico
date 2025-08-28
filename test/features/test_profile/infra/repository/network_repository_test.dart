import 'package:demopico/core/common/files_manager/mappers/i_mapper_dto.dart';
import 'package:demopico/features/profile/domain/models/connection.dart';
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

    test('should return a list of users when connections exist', () async {
      // Arrange
      when(() => mockNetworkService.getConnections(any()))
          .thenAnswer((_) async => [
            mapper.toDTO(mockUserProfile),
            mapper.toDTO(mockUserProfile2)
          ]);

      // Act
      final result = await repository.getConnections(userID);

      // Assert
      expect(result, isA<List<UserM>>());
      expect(result, isNotEmpty);
      expect(result.length, 2);
      verify(() => mockNetworkService.getConnections(userID)).called(1);
    });

    test('should return an empty list when no connections exist', () async {
      // Arrange
      when(() => mockNetworkService.getConnections(any()))
          .thenAnswer((_) async => []);

      // Act
      final result = await repository.getConnections(userID);

      // Assert
      expect(result, isEmpty);
      verify(() => mockNetworkService.getConnections(userID)).called(1);
    });

    test('should throw an exception on a server error', () async {
      // Arrange
      when(() => mockNetworkService.getConnections(any()))
          .thenThrow(Exception('Server error'));

      // Act & Assert
      expect(() => repository.getConnections(userID), throwsA(isA<Exception>()));
      verify(() => mockNetworkService.getConnections(userID)).called(1);
    });
  });
  
  
  group('connectUser', () {


    test('should complete successfully when connecting two valid users', () async {
      // Arrange
      when(() => mockNetworkService.createConnection(any())).thenAnswer((_) async => Future.value(mapperConnection.toDTO(dummyConnections[0])));

      // Act
      await repository.createConnection(dummyConnections[0]);

      // Assert
      verifyNever(() => mockNetworkService.createConnection(mapperConnection.toDTO(dummyConnections[0])));
    });

    test('should throw an exception if users are already connected', () async {
      // Arrange
      when(() => mockNetworkService.createConnection(any())).thenThrow(Exception('Already connected'));

      // Act & Assert
      expect(() => repository.createConnection(dummyConnections[0]), throwsA(isA<Exception>()));    });
  });
  
  
  
  group('disconnectUser', () {
    // TODO CORRIGIR ESSES TESTES 
    test('should complete successfully when disconnecting two connected users', () async {
      // Arrange
      when(() => mockNetworkService.disconnectUser(any())).thenAnswer((_) async => Future.value());

      // Act
      await repository.disconnectUser(dummyConnections[0]);
      
      
    });

    test('should throw an exception if users are not connected', () async {
      // Arrange
      when(() => mockNetworkService.disconnectUser(any())).thenThrow(Exception('Not connected'));

      // Act & Assert
      expect(() => repository.disconnectUser(dummyConnections[2]), throwsA(isA<Exception>()));
    });
  });
  
  
  
  group('getConnectionRequests', () {
    const String userID = 'user123';

    test('should return a list of connections when requests exist', () async {
      // Arrange
      when(() => mockNetworkService.fetchRequestConnections(any()))
          .thenAnswer((_) async => Future.value([
            mapperConnection.toDTO(dummyConnections[1]),
            mapperConnection.toDTO(dummyConnections[2])
          ]));

      // Act
      final result = await repository.getConnectionRequests(userID);

      // Assert
      expect(result, isA<List<Connection>>());
      expect(result, isNotEmpty);
      expect(result.length, 2);
      verify(() => mockNetworkService.fetchRequestConnections(userID)).called(1);
    });

    test('should return an empty list when no requests exist', () async {
      // Arrange
      when(() => mockNetworkService.fetchRequestConnections(any()))
          .thenAnswer((_) async => []);

      // Act
      final result = await repository.getConnectionRequests(userID);

      // Assert
      expect(result, isEmpty);
      verify(() => mockNetworkService.fetchRequestConnections(userID)).called(1);
    });

    test('should throw an exception on a server error', () async {
      // Arrange
      when(() => mockNetworkService.fetchRequestConnections(any()))
          .thenThrow(Exception('Server error'));

      // Act & Assert
      expect(() => repository.getConnectionRequests(userID), throwsA(isA<Exception>()));
      verify(() => mockNetworkService.fetchRequestConnections(userID)).called(1);
    });
  });
}


