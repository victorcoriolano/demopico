import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_firebase_datasource.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import '../../mocks/mocks_profile.dart';

class MockCrudDataSource extends Mock implements CrudFirebase {}


void main() {
  late MockCrudDataSource mockCrudDataSource;
  late UserFirebaseDataSource dataSource;

  setUp(() {
    mockCrudDataSource = MockCrudDataSource();
    dataSource = UserFirebaseDataSource(datasource: mockCrudDataSource as dynamic);
  });

  group('UserFirebaseDataSource', () {

    setUpAll(() {
      registerFallbackValue(listDtosUser[0]);
    });

    test('addUserDetails calls setData', () async {
      when(() => mockCrudDataSource.setData(any(), any())).thenAnswer((_) async => listDtosUser[0]);
      await dataSource.addUserDetails(listDtosUser[0]);
      verify(() => mockCrudDataSource.setData(listDtosUser[0].id, listDtosUser[0])).called(1);
    });

    test('addUserDetails throws mapped FirebaseException', () async {
      when(() => mockCrudDataSource.setData(any(), any())).thenThrow(UnknownFailure());
      expect(
        () => dataSource.addUserDetails(listDtosUser[0]),
        throwsA(isA<Failure>()),
      );
    });

    test('getUserDetails returns dto', () async {
      when(() => mockCrudDataSource.read('1')).thenAnswer((_) async => listDtosUser[0]);
      final result = await dataSource.getUserDetails('1');
      expect(result, listDtosUser[0]);
    });

    test('getUserDetails throws mapped FirebaseException', () async {
      when(() => mockCrudDataSource.read(any())).thenThrow(UnknownFailure());
      expect(
        () => dataSource.getUserDetails('123'),
        throwsA(isA<Failure>()),
      );
    });

    test('getUserData returns field value', () async {
      when(() => mockCrudDataSource.read(any())).thenAnswer((_) async => listDtosUser[0]);
      final result = await dataSource.getUserData('1', 'email');
      expect(result, 'test@email.com');
    });

    test('getUserByField returns first dto', () async {
      when(() => mockCrudDataSource.readAllWithFilter(any(), any())).thenAnswer((_) async => listDtosUser);
      final result = await dataSource.getUserByField('email', 'test@email.com');
      expect(result.id, listDtosUser[0].id);
      expect(result.data, listDtosUser[0].data);
    });

    test('should validate data Exists', () async {
      when(() => mockCrudDataSource.existsDataWithField(any(), any())).thenAnswer((_) async => true);
      final result = await dataSource.validateExistsData('email', 'test@email.com');
      expect(result, true);
    });
    test('should validate Data not Exists', () async {
      when(() => mockCrudDataSource.existsDataWithField(any(), any())).thenAnswer((_) async => false);
      final result = await dataSource.validateExistsData('email', 'test@email.com');
      expect(result, false);
    });

    test('update calls update', () async {
      when(() => mockCrudDataSource.update(any())).thenAnswer((_) async => listDtosUser[1]);
      await dataSource.update(listDtosUser[1]);
      verify(() => mockCrudDataSource.update(listDtosUser[1])).called(1);
    });

    test('should returns FirebaseDTO list', () async {
      when(() => mockCrudDataSource.readMultiplesExcept(any(), any())).thenAnswer((_) async => listDtosUser);
      final result = await dataSource.getSuggestions({'test'});
      expect(result, isA<List<FirebaseDTO>>());
    });

    test('searchUsers returns FirebaseDTO list', () {
      when(() => mockCrudDataSource.watchWithFilter(any(), any())).thenAnswer((_) => Stream.value(listDtosUser));
      final result = dataSource.searchUsers('query');
      expect(result, isA<Stream<List<FirebaseDTO>>>());
    });
  });
}