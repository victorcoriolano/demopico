import 'dart:async';
import 'package:demopico/core/common/auth/domain/entities/auth_result.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_auth_repository.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
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
      profileRepository: ProfileRepositoryImpl.getInstance, 
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
        _profileRepository= profileRepository ;

  UserEntity? cachedUser;

  void updateStream(AuthState newState){
    _lastState = newState;
    _stateController.add(newState);
    debugPrint("Estado atual da autenticação: ${_lastState.toString()}");

  }

  Future<void> _onAuthChanges(fb.User? fu) async {
    debugPrint("Estado da autenticação mudou!");
    if (fu == null) {
      debugPrint("User null");
      updateStream(AuthUnauthenticated());
      return;
    }

    debugPrint("User logado no firebase: ${fu.uid} - ${fu.email} - ${fu.displayName}");
    final model = await _userRepo.getById(fu.uid);
    debugPrint("UserModel do banco: $model");
    final profileResult = await _profileRepository.getProfileByUser(fu.uid);
    debugPrint("profile result = $profileResult - Success${profileResult.success}");

    if(profileResult.failure != null) {
      debugPrint("Não foi possível encontrar o perfil do user, lançando falha e deslogando do firebase auth");
      signOut();
      throw ProfileNotFoundFailure(originalException: profileResult.failure);
    }

    cachedUser = UserMapper.toEntity(model, profileResult.profile!);
    debugPrint("Usuário autenticado: $cachedUser");
    updateStream(AuthAuthenticated(user: cachedUser!)); 
  }

  Future<UserEntity>  _createDefaultProfileFromFirebaseUser(fb.User fu, NormalUserCredentialsSignUp credentials) async {
    final userInitial = UserEntity.initial(fu.uid, VulgoVo(credentials.vulgo.value), EmailVO(fu.email!), credentials.location, fu.photoURL);
    final userM = await _userRepo.addUserDetails(UserMapper.fromEntity(userInitial));
    debugPrint("UserModel criado: $userM");
    final profileresult = await _profileRepository.createProfile(userInitial.profileUser);
    if (profileresult.success){
      return userInitial;
    } else {
      debugPrint("Erro ao criar perfil padrão do usuário: ${profileresult.failure}");
      // Se não conseguir criar o perfil, deve apagar o usuário criado no Firebase Auth e no Firestore
      await fu.delete();
      await _userRepo.deleteData(fu.uid);
      throw profileresult.failure!;
    }
  }

  @override
  Stream<AuthState> get authState => _stateController.stream;

  @override
  Future<void> signOut() async {
    await _fa.signOut();
    _onAuthChanges(null);
    updateStream(AuthUnauthenticated());
    cachedUser = null;
  }

  @override
  Future<AuthResult> signInWithEmail(EmailCredentialsSignIn credentials) async {
    try {
      final fuCredentials =await _fa.signInWithEmailAndPassword(
          email: credentials.identifier.value, password: credentials.senha.value);
      await _onAuthChanges(fuCredentials.user);
      return AuthResult.success(user: cachedUser!);
    } on fb.FirebaseAuthException catch (fbException) {
      return AuthResult.failure(FirebaseErrorsMapper.map(fbException));
    }on DomainFailure catch (domainFailure){
      debugPrint("ERRO DE DOMÍNIO: $domainFailure");
      return AuthResult.failure(domainFailure);
    } catch (unknownError, st){
      return AuthResult.failure(UnknownFailure(unknownError: unknownError, stackTrace: st));
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
      debugPrint("Criando usuário no Firebase com email: ${credentials.email.value} e vulgo: ${credentials.vulgo.value}");
      final cred = await _fa.createUserWithEmailAndPassword(
        email: credentials.email.value, 
        password: credentials.password.value);
      debugPrint("Usuário criado no Firebase: ${cred.user}");
      final fu = cred.user!;
      await fu.updateDisplayName(credentials.vulgo.value);

      final domainUser = await _createDefaultProfileFromFirebaseUser(fu, credentials);
      
      return AuthResult.success(user: domainUser);
    } on fb.FirebaseAuthException catch (fbException){
      debugPrint("Repository - erro no firebase: $fbException");
      return AuthResult.failure(FirebaseErrorsMapper.map(fbException));
    } on DomainFailure catch (domainFailure){
      debugPrint("ERRO DE DOMÍNIO: $domainFailure");
      return AuthResult.failure(domainFailure);
    } catch (unknownError, st){
      debugPrint("Erro desconhecido: $unknownError");
      return AuthResult.failure(UnknownFailure(unknownError: unknownError, stackTrace: st));
    }
  }
  
  @override
  UserEntity? get currentUser {
    debugPrint('Getting current user: $cachedUser');
    return cachedUser;
  }
}