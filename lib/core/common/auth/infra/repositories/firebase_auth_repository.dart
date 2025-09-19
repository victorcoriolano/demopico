import 'dart:async';
import 'package:demopico/core/common/auth/domain/entities/auth_result.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_auth_repository.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_profile_repository.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/core/common/auth/infra/mapper/user_mapper.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:demopico/features/profile/infra/repository/profile_repository.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';

class FirebaseAuthRepository implements IAuthRepository {

  // Singleton 
  static FirebaseAuthRepository? _instance;
  static FirebaseAuthRepository get instance {
    return _instance ?? FirebaseAuthRepository(
      profileRepository: ProfileRepositoryImpl.instance, 
      userRepository: UserDataRepositoryImpl.getInstance, 
      datasource: fb.FirebaseAuth.instance);
  }
  final fb.FirebaseAuth _fa;
  final IUserRepository _userRepo;
  final IProfileRepository _profileRepository;
  final _stateController = StreamController<AuthState>.broadcast();
  AuthState _lastState = AuthUnauthenticated();

  FirebaseAuthRepository({
    required IProfileRepository profileRepository,
    required IUserRepository userRepository,
    required fb.FirebaseAuth datasource})
      : _fa = datasource,
        _userRepo = userRepository,
        _profileRepository= profileRepository {
    _fa.authStateChanges().listen(_onAuthChanges);
  }

  UserEntity? cachedUser;

  void _updateStream(AuthState newState){
    _stateController.add(newState);
    _lastState = newState;
  }

  void _onAuthChanges(fb.User? fu) async {
    debugPrint("Estado da autenticação mudou!");
    if (fu == null) {
      debugPrint("User null");
      _updateStream(AuthUnauthenticated());
      return;
    }

    debugPrint("User logado");
    final model = await _userRepo.getById(fu.uid);
    final profileResult = await _profileRepository.getProfileByUser(fu.uid);

    if(profileResult.failure != null) {
      throw ProfileNotFoundFailure(originalException: profileResult.failure);
    }

    cachedUser = UserMapper.toEntity(model, profileResult.profile!);
    _updateStream(AuthAuthenticated(user: cachedUser!)); 
  }

  Future<UserEntity> _createDefaultProfileFromFirebaseUser(fb.User fu, [LocationVo? location]) async {
    final userInitial = UserEntity.initial(fu.uid, VulgoVo(fu.displayName ?? "Não especificado",), EmailVO(fu.email!), location, fu.photoURL);
    await _userRepo.addUserDetails(UserMapper.fromEntity(userInitial));
    await _profileRepository.createProfile(userInitial.profileUser);
    return userInitial;
  }

  @override
  Stream<AuthState> get authState => _stateController.stream;

  @override
  Future<void> signOut() async {
    await _fa.signOut();
    _updateStream(AuthUnauthenticated());
  }

  @override
  Future<AuthResult> signInWithEmail(EmailCredentialsSignIn credentials) async {
    try {
      await _fa.signInWithEmailAndPassword(
          email: credentials.identifier.value, password: credentials.senha.value);
      return AuthResult.success(user: cachedUser!);
    } on fb.FirebaseAuthException catch (fbException) {
      return AuthResult.failure(FirebaseErrorsMapper.map(fbException));
    } catch (unknownError){
      return AuthResult.failure(UnknownFailure(unknownError: unknownError));
    }
  }

  @override
  Future<AuthResult> signInWithGoogle(GoogleCredentialsSignIn credentials) {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }



  @override
  Future<AuthResult> signUp(NormalUserCredentialsSignUp credentials) async {
    try {
      final cred = await _fa.createUserWithEmailAndPassword(
        email: credentials.email.value, 
        password: credentials.password.value);
      final fu = cred.user!;
      await fu.updateDisplayName(credentials.vulgo.value);
      final domainUser = await _createDefaultProfileFromFirebaseUser(fu, credentials.location);
      return AuthResult.success(user: domainUser);
    } on fb.FirebaseAuthException catch (fbException){
      return AuthResult.failure(FirebaseErrorsMapper.map(fbException));
    } catch (unknownError){
      return AuthResult.failure(UnknownFailure(unknownError: unknownError));
    }
  }
  
  @override
  AuthState get currentAuthState  => _lastState;
}