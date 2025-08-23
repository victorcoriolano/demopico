import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_firebase_datasource.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/interfaces/i_crud_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';

class MockCrudDataSource extends Mock implements ICrudDataSource<FirebaseDTO, FirebaseFirestore> {}


void main() {
  late MockCrudDataSource mockCrudDataSource;
  late UserFirebaseDataSource dataSource;

  setUp(() {
    mockCrudDataSource = MockCrudDataSource();
    dataSource = UserFirebaseDataSource(datasource: mockCrudDataSource as dynamic);
  });

  group('UserFirebaseDataSource', () {

    test('addUserDetails calls setData', () async {
      when(mockCrudDataSource.setData("any()", "any()")).thenAnswer((_) async => {});
      await dataSource.addUserDetails(testDto);
      verify(mockCrudDataSource.setData(testDto.id, testDto)).called(1);
    });

    test('addUserDetails throws mapped FirebaseException', () async {
      final exception = FirebaseException(plugin: 'test');
      when(mockCrudDataSource.setData("any()", "any()")).thenThrow(exception);
      expect(
        () => dataSource.addUserDetails(testDto),
        throwsA(isA<Failure>()),
      );
    });

    test('getUserDetails returns dto', () async {
      when(mockCrudDataSource.read("any()")).thenAnswer((_) async => testDto);
      final result = await dataSource.getUserDetails('123');
      expect(result, testDto);
    });

    test('getUserDetails throws mapped FirebaseException', () async {
      final exception = FirebaseException(plugin: 'test');
      when(mockCrudDataSource.read("any()")).thenThrow(exception);
      expect(
        () => dataSource.getUserDetails('123'),
        throwsA(isA<Failure>()),
      );
    });

    test('getUserData returns field value', () async {
      when(mockCrudDataSource.read("any()")).thenAnswer((_) async => testDto);
      final result = await dataSource.getUserData('123', 'email');
      expect(result, 'john@test.com');
    });

    test('getUserByField returns first dto', () async {
      when(mockCrudDataSource.readAllWithFilter("any()", "any()")).thenAnswer((_) async => [testDto]);
      final result = await dataSource.getUserByField('email', 'john@test.com');
      expect(result.id, testDto.id);
      expect(result.data, testDto.data);
    });

    test('validateExistsData returns true', () async {
      when(mockCrudDataSource.existsDataWithField(""any()"", "john@test.com")).thenAnswer((_) async => true);
      final result = await dataSource.validateExistsData('email', 'john@test.com');
      expect(result, true);
    });

    test('update calls update', () async {
      when(mockCrudDataSource.update(testDto)).thenAnswer((_) async => {});
      await dataSource.update(testDto);
      verify(mockCrudDataSource.update(testDto)).called(1);
    });

    test('should returns FirebaseDTO list', () {
      expect(() => dataSource.getSuggestions(['test']), isA<List<FirebaseDTO>>());
    });

    test('searchUsers returns FirebaseDTO list', () {
      expect(() => dataSource.searchUsers('query'), isA<List<FirebaseDTO>>());
    });
  });
}