import 'package:demopico/core/common/auth/domain/interfaces/i_user_account_repository.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class FirebaseAccountRepository implements IUserAccountRepository {
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
  Future<void> sendEmailVerification() async {
    if (_fa.currentUser == null) return;
    try {
      _fa.currentUser!.sendEmailVerification();
    } catch (e) {
      debugPrint("Erro ao enviar email de verificação: $e");
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
