import 'package:demopico/core/common/auth/domain/interfaces/i_user_account_repository.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class FirebaseAccountRepository implements IUserAccountRepository {

  static FirebaseAccountRepository? _instance;
  static FirebaseAccountRepository get instance => 
    _instance ??= FirebaseAccountRepository(
      userRepository: UserDataRepositoryImpl.getInstance, 
      datasource: fb.FirebaseAuth.instance);

  FirebaseAccountRepository(
      {required IUserRepository userRepository,
      required fb.FirebaseAuth datasource})
      : _fa = datasource,
        _userRepo = userRepository;

  final fb.FirebaseAuth _fa;
  final IUserRepository _userRepo;

  @override
  bool get isVerified => _fa.currentUser?.emailVerified ?? false;

  @override
  Future<bool> sendEmailVerification() async {
    if (_fa.currentUser == null) return false;
    try {
      _fa.currentUser!.sendEmailVerification();
      return true;
    } catch (e) {
      debugPrint("Erro ao enviar email de verificação: $e");
      return false;
    }
  }

  @override
  Future<bool> changePassWord() async {
    if (_fa.currentUser == null || _fa.currentUser?.email == null) return false;
    try {
      final fu = _fa.currentUser;
      await _fa.sendPasswordResetEmail(email: fu!.email!);
      return true;
    } on fb.FirebaseAuthException catch (fbException) {
      debugPrint("FAA - Erro ao autualizar alterar senha - $fbException");
      rethrow;
    } catch (unknownError) {
      debugPrint(
          "FAA - Erro ao não identificado ao alterar senha - $unknownError");
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async {
    if (_fa.currentUser == null) return;
    try {
      await _fa.currentUser!.delete();
      await _userRepo.deleteData(_fa.currentUser!.uid);
    } on fb.FirebaseAuthException catch (exception) {
      throw FirebaseErrorsMapper.map(exception);
    }
  }
}
