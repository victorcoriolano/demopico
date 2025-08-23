import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_firebase_datasource.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/interfaces/i_crud_datasource.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import '../../mocks/mocks_profile.dart';

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
      when(() => mockCrudDataSource.setData(any(), any())).thenAnswer((_) async => listDtosUser[1]);
      await dataSource.addUserDetails(listDtosUser[1]);
      verify(() => mockCrudDataSource.setData(listDtosUser[1].id, listDtosUser[1])).called(1);
    });

    test('addUserDetails throws mapped FirebaseException', () async {
      when(() => mockCrudDataSource.setData(any(), any())).thenThrow(UnknownFailure());
      expect(
        () => dataSource.addUserDetails(listDtosUser[1]),
        throwsA(isA<Failure>()),
      );
    });

    test('getUserDetails returns dto', () async {
      when(() => mockCrudDataSource.read(any())).thenAnswer((_) async => listDtosUser[1]);
      final result = await dataSource.getUserDetails('123');
      expect(result, listDtosUser[1]);
    });

    test('getUserDetails throws mapped FirebaseException', () async {
      when(() => mockCrudDataSource.read(any())).thenThrow(UnknownFailure());
      expect(
        () => dataSource.getUserDetails('123'),
        throwsA(isA<Failure>()),
      );
    });

    test('getUserData returns field value', () async {
      when(() => mockCrudDataSource.read(any())).thenAnswer((_) async => listDtosUser[1]);
      final result = await dataSource.getUserData('123', 'email');
      expect(result, 'john@test.com');
    });

    test('getUserByField returns first dto', () async {
      when(() => mockCrudDataSource.readAllWithFilter(any(), any())).thenAnswer((_) async => listDtosUser);
      final result = await dataSource.getUserByField('email', 'john@test.com');
      expect(result.id, listDtosUser[0].id);
      expect(result.data, listDtosUser[0].data);
    });

    test('should validate data Exists', () async {
      when(() => mockCrudDataSource.existsDataWithField(any(), any())).thenAnswer((_) async => true);
      final result = await dataSource.validateExistsData('email', 'john@test.com');
      expect(result, true);
    });
    test('should validate Data not Exists', () async {
      when(() => mockCrudDataSource.existsDataWithField(any(), any())).thenAnswer((_) async => false);
      final result = await dataSource.validateExistsData('email', 'john@test.com');
      expect(result, false);
    });

    test('update calls update', () async {
      when(() => mockCrudDataSource.update(any())).thenAnswer((_) async => listDtosUser[1]);
      await dataSource.update(listDtosUser[1]);
      verify(() => mockCrudDataSource.update(listDtosUser[1])).called(1);
    });

    test('should returns FirebaseDTO list', () {
      expect(() => dataSource.getSuggestions(['test']), isA<List<FirebaseDTO>>());
    });

    test('searchUsers returns FirebaseDTO list', () {
      expect(() => dataSource.searchUsers('query'), isA<List<FirebaseDTO>>());
    });
  });
}