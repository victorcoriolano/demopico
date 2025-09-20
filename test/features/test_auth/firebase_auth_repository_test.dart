import 'dart:async';

import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/features/profile/domain/models/profile_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_auth_repository.dart';
import 'package:demopico/core/common/auth/domain/entities/auth_result.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import ".././mocks/mocks_users.dart";
import '../mocks/mocks_profiles.dart';

class MockFirebaseAuth extends Mock implements fb.FirebaseAuth {}
class MockUser extends Mock implements fb.User {}
class MockUserCredential extends Mock implements fb.UserCredential {}
class MockUserRepository extends Mock implements IUserRepository {}
class MockProfileRepository extends Mock implements IProfileRepository {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserRepository mockUserRepo;
  late MockProfileRepository mockProfileRepo;
  late FirebaseAuthRepository repository;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserRepo = MockUserRepository();
    mockProfileRepo = MockProfileRepository();
    repository = FirebaseAuthRepository(
      profileRepository: mockProfileRepo,
      userRepository: mockUserRepo,
      datasource: mockFirebaseAuth,
    );
  });

  group('signInWithEmail', () {
    test('returns AuthResult.success when sign in succeeds', () async {
      final credentials = EmailCredentialsSignIn(
        identifier: EmailVO('test@test.com'),
        senha: PasswordVo('password123'),
      );
      final mockUser = MockUser();
      repository.cachedUser = UserEntity.initial(
        'uid',
        VulgoVo('Test'),
        EmailVO('test@test.com'),
        null,
        null,
      );
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: "test@test.com",
        password: "password123",
      )).thenAnswer((_) async => MockUserCredential());

      final result = await repository.signInWithEmail(credentials);

      expect(result.success, true);
      expect(result.user, isNotNull);
    });

    test('returns AuthResult.failure on FirebaseAuthException', () async {
      final credentials = EmailCredentialsSignIn(
        identifier: EmailVO('test@test.com'),
        senha: PasswordVo('password123'),
      );
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: "teste@teste.com",
        password: "password123",
      )).thenThrow(fb.FirebaseAuthException(code: 'user-not-found'));

      final result = await repository.signInWithEmail(credentials);

      expect(result.success, false);
      expect(result.failure, isA<RepositoryFailures>());
    });
  });

  group('signUp', () {
    test('returns AuthResult.success when () => sign up succeeds', () async {
      final credentials = NormalUserCredentialsSignUp(
        email: EmailVO('new@test.com'),
        password: PasswordVo('password123'),
        vulgo: VulgoVo('NewUser'),
        location:  LocationVo(latitude: 0.0,longitude:  0.0),
      );
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.updateDisplayName(any())).thenAnswer((_) async {});
      when(() => mockUser.uid).thenReturn('newuid');
      when(() => mockUser.displayName).thenReturn('NewUser');
      when(() => mockUser.email).thenReturn('new@test.com');
      when(() => mockUser.photoURL).thenReturn(null);

      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: "teste@teste.com",
        password: "password123",
      )).thenAnswer((_) async => mockUserCredential);

      when(() => mockUserRepo.addUserDetails(any())).thenAnswer((_) async {return mockUserProfile;});
      when(() => mockProfileRepo.createProfile(any())).thenAnswer((_) async {return  ProfileResult.success(profile: mockProfileCompleto);});

      final result = await repository.signUp(credentials);

      expect(result.success, true);
      expect(result.user, isNotNull);
    });

    test('returns AuthResult.failure on FirebaseAuthException', () async {
      final credentials = NormalUserCredentialsSignUp(
        email: EmailVO('fail@test.com'),
        password: PasswordVo('password123'),
        vulgo: VulgoVo('FailUser'),
        location: LocationVo(latitude: 0.0,longitude:  0.0),
      );
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: "teste@teste.com",
        password: "password123",
      )).thenThrow(fb.FirebaseAuthException(code: 'email-already-in-use'));

      final result = await repository.signUp(credentials);

      expect(result.failure != null, true);
      expect(result.failure, isA<RepositoryFailures>());
    });
  });

  group('signOut', () {
    test('calls signOut on FirebaseAuth and updates state', () async {
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});
      await repository.signOut();
      expect(repository.currentAuthState, isA<AuthUnauthenticated>());
    });
  });

  group('authState stream', () {
    test('emits AuthUnauthenticated when user is null', () async {
      final controller = StreamController<fb.User?>();
      when(() => mockFirebaseAuth.authStateChanges()).thenAnswer((_) => controller.stream);

      final repo = FirebaseAuthRepository(
        profileRepository: mockProfileRepo,
        userRepository: mockUserRepo,
        datasource: mockFirebaseAuth,
      );

      expectLater(repo.authState, emits(isA<AuthUnauthenticated>()));
      controller.add(null);
      await controller.close();
    });
  });
}