import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_service.dart';

class MockUserDataSource extends Mock implements IUserDataSource<FirebaseDTO> {}


void main() {
  late MockUserDataSource mockDataSource;
  late UserDataRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockUserDataSource();
    repository = UserDataRepositoryImpl(userFirebaseService: mockDataSource);
  });

  group('UserDataRepositoryImpl', () {
    test('addUserDetails sets local user and calls data source', () async {
      when(() => mockDataSource.addUserDetails(any())).thenAnswer((_) async {});
      await repository.addUserDetails(user);
      expect(repository.localUser, user);
      verify(() => mockDataSource.addUserDetails(any())).called(1);
    });

    test('getUserDetailsByID returns local user if set', () async {
      repository._userLocalDetails = user;
      final result = await repository.getUserDetailsByID('123');
      expect(result, user);
      verifyNever(() => mockDataSource.getUserDetails(any()));
    });

    test('getUserDetailsByID fetches and sets local user if not set', () async {
      when(() => mockDataSource.getUserDetails('123')).thenAnswer((_) async => dto);
      final result = await repository.getUserDetailsByID('123');
      expect(result.id, '123');
      expect(repository.localUser?.id, '123');
      verify(() => mockDataSource.getUserDetails('123')).called(1);
    });

    test('updateUserDetails updates local user and calls data source', () async {
      when(() => mockDataSource.update(any())).thenAnswer((_) async {});
      final result = await repository.updateUserDetails(user);
      expect(result, user);
      expect(repository.localUser, user);
      verify(() => mockDataSource.update(any())).called(1);
    });

    test('getEmailByVulgo returns email from mapped model', () async {
      when(() => mockDataSource.getUserByField('name', 'Test')).thenAnswer((_) async => dto);
      final email = await repository.getEmailByVulgo('Test');
      expect(email, 'test@email.com');
      verify(() => mockDataSource.getUserByField('name', 'Test')).called(1);
    });

    test('validateExist calls data source and returns result', () async {
      when(() => mockDataSource.validateExistsData('email', 'test@email.com')).thenAnswer((_) async => true);
      final exists = await repository.validateExist(data: 'test@email.com', field: 'email');
      expect(exists, true);
      verify(() => mockDataSource.validateExistsData('email', 'test@email.com')).called(1);
    });

    test('getSuggestions throws UnimplementedError', () {
      expect(() => repository.getSuggestions(['test']), throwsUnimplementedError);
    });

    test('searchUsers throws UnimplementedError', () {
      expect(() => repository.searchUsers('test'), throwsUnimplementedError);
    });
  });
}