import 'package:demopico/core/common/auth/domain/entities/profile_user.dart';
import 'package:demopico/core/common/auth/domain/value_objects/dob_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/user_rule_vo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:demopico/core/common/auth/domain/entities/auth_credentials.dart';
import 'package:demopico/core/common/auth/domain/entities/auth_result.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_auth_repository.dart';

// Mock classes
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
  });

  group('IAuthRepository', () {
    test('signInWithEmail returns AuthResult', () async {
      final credentials = EmailPasswordCredentials(
        email: EmailVO('test@example.com'),
        password: PasswordVo('password123'),
      );
      final expectedResult = AuthResult.success(
        user: UserEntity(
          id: '1', 
          email: EmailVO('test@example.com'), 
          rule: UserRuleVO.normalUser, 
          displayName: 'name', 
          dob: DobVo(DateTime.now()), 
          location: LocationVo(latitude: 30.0, longitude: 32.42), 
          profileUser: ProfileFactory.initialFromUser("1", "name")));

      when(authRepository.signInWithEmail(credentials)).thenAnswer((_) async => expectedResult);

      final result = await authRepository.signInWithEmail(credentials);

      expect(result, expectedResult);
    });

    test('signInWithGoogle returns AuthResult', () async {
      final expectedResult = AuthResult.success(
        user: UserEntity(
          id: '1', 
          email: EmailVO('test@example.com'), 
          rule: UserRuleVO.normalUser, 
          displayName: 'name', 
          dob: DobVo(DateTime.now()), 
          location: LocationVo(latitude: 30.0, longitude: 32.42), 
          profileUser: ProfileFactory.initialFromUser("1", "name")));
      when(authRepository.signInWithGoogle()).thenAnswer((_) async => expectedResult);

      final result = await authRepository.signInWithGoogle();

      expect(result, expectedResult);
    });

    test('signOut completes', () async {
      when(authRepository.signOut()).thenAnswer((_) async {});

      await authRepository.signOut();

      verify(authRepository.signOut()).called(1);
    });

    test('signUp returns UserEntity', () async {
      final credentials = NormalUserSignUpCredentials(
        email: EmailVO('newuser@example.com'),
        password: PasswordVo('newpassword'),
        initialProfile: ProfileFactory.initialFromUser("1", "displayName"), name: 'displayName'
      );
      final expectedUser = UserEntity(
        id: '3',
        email: EmailVO('newuser@example.com'),
        rule: UserRuleVO.normalUser,
        displayName: 'displayName',
        dob: DobVo(DateTime.now()),
        location: LocationVo(latitude: 0.0, longitude: 0.0),
        profileUser: ProfileFactory.initialFromUser("3", "displayName"),
      );
      when(authRepository.signUp(credentials)).thenAnswer((_) async => expectedUser);

      final result = await authRepository.signUp(credentials);

      expect(result, expectedUser);
    });

    test('authState emits AuthState', () async {
      final stream = Stream<AuthState>.fromIterable([AuthState.loggedIn, AuthState.notLoggedIn]);
      when(authRepository.authState).thenAnswer((_) => stream);

      expect(authRepository.authState, emitsInOrder([AuthState.loggedIn, AuthState.notLoggedIn]));
    });

    test('currentUser returns TypeUser', () {
      final user = UserEntity(
        id: '4',
        email: EmailVO('current@example.com'),
        rule: UserRuleVO.normalUser,
        displayName: '',
        dob: DobVo(DateTime(2000, 1, 1)),
        location: LocationVo(latitude: 0.0, longitude: 0.0),
        profileUser: ProfileFactory.initialFromUser("userID", "displayName"),
      );
      when(authRepository.currentUser).thenReturn(user);
      final currentUser = authRepository.currentUser;
      expect(authRepository.currentUser, user);
    });
  });
}