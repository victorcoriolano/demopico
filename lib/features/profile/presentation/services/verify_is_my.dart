import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class VerifyIsMy {
  static bool isMy(String idPost, BuildContext currentContext){
    final userAuthState = currentContext.watch<AuthState>();
    switch (userAuthState){
      case AuthAuthenticated():
        return idPost == userAuthState.user.id;
      case AuthUnauthenticated():
        return false;
    }
  }
}