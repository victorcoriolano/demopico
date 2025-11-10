import 'package:demopico/core/common/auth/domain/interfaces/i_user_account_repository.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/mappers/firebase_errors_mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class FirebaseAccountRepository implements IUserAccountRepository {

  static FirebaseAccountRepository? _instance;
  static FirebaseAccountRepository get instance => 
    _instance ??= FirebaseAccountRepository( 
      datasource: fb.FirebaseAuth.instance);

  FirebaseAccountRepository(
      {required fb.FirebaseAuth datasource})
      : _fa = datasource; 

  final fb.FirebaseAuth _fa;

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
  Future<bool> resetPassword(String email) async {
    try { 
      await _fa.sendPasswordResetEmail(email: email);
      return true;
    } on fb.FirebaseAuthException catch (fbException) {
      debugPrint("FA Repo - Erro ao autualizar alterar senha - $fbException");
      return false;
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
    } on fb.FirebaseAuthException catch (exception) {
      throw FirebaseErrorsMapper.map(exception);
    }
  }

  @override
  Future<void> updatePassword(PasswordVo password) async {
    if (_fa.currentUser == null) return;
    try {
      await _fa.currentUser!.updatePassword(password.value);
    } on fb.FirebaseAuthException catch (exception) {
      throw FirebaseErrorsMapper.map(exception);
    }
  }
}


