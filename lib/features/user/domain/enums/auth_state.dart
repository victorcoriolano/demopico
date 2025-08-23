import 'package:demopico/features/user/domain/models/user.dart';

enum AuthState { 
  notLoggedIn,
  loggedInWithGoogle,
  loggedInWithPhone,
  loggedIn;

  factory AuthState.fromUserState(UserM? user){
    return user != null 
      ?  AuthState.loggedIn
      : AuthState.notLoggedIn;
  }
}