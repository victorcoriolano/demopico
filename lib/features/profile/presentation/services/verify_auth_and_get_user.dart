
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyAuthAndGetUser {
  static UserEntity? verify(BuildContext context){
    final userAuthState = context.watch<AuthState>();
    switch (userAuthState){
      case AuthAuthenticated():
        return userAuthState.user;
      case AuthUnauthenticated(): 
        return null;
    }
  }
}