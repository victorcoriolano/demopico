import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_service.dart';

import '../../mocks/mocks_profile.dart';

class MockUserDataSource extends Mock implements IUserDataSource<FirebaseDTO> {}


void main() {
  late MockUserDataSource mockDataSource;
  late UserDataRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockUserDataSource();
    repository = UserDataRepositoryImpl(userFirebaseService: mockDataSource);
  });

  setUpAll(() {
    registerFallbackValue(listDtosUser[1]);
  });

  group('UserDataRepositoryImpl test', () {
    test('addUserDetails sets local user and calls data source', () async {
      when(() => mockDataSource.addUserDetails(any())).thenAnswer((_) async {});
      await repository.addUserDetails(mockUserProfile);
      expect(repository.localUser, mockUserProfile);
      verify(() => mockDataSource.addUserDetails(any())).called(1);
    });


    test('getUserDetailsByID fetches and sets local user if not set', () async {
      when(() => mockDataSource.getUserDetails('1')).thenAnswer((_) async => listDtosUser[0]);
      final result = await repository.getUserDetailsByID('1');
      expect(result.id, '1');
      expect(repository.localUser?.id, '1');
      verify(() => mockDataSource.getUserDetails('1')).called(1);
    });

    test('updateUserDetails updates local user and calls data source', () async {
      when(() => mockDataSource.update(any())).thenAnswer((_) async {});
      final result = await repository.updateUserDetails(mockUserProfile);
      expect(result, mockUserProfile);
      expect(repository.localUser, mockUserProfile);
      verify(() => mockDataSource.update(any())).called(1);
    });

    test('getEmailByVulgo returns email from mapped model', () async {
      when(() => mockDataSource.getUserByField(any(), any())).thenAnswer((_) async => listDtosUser.first);
      final email = await repository.getEmailByVulgo('artu');
      expect(email, 'test@email.com');
      verify(() => mockDataSource.getUserByField('name', 'artu')).called(1);
    });

    test('validateExist calls data source and returns result', () async {
      when(() => mockDataSource.validateExistsData('email', 'test@email.com')).thenAnswer((_) async => true);
      final exists = await repository.validateExist(data: 'test@email.com', field: 'email');
      expect(exists, true);
      verify(() => mockDataSource.validateExistsData('email', 'test@email.com')).called(1);
    });
  });
}