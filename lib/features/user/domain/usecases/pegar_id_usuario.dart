import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/infra/datasource/remote/firebase_auth_service.dart';


class PegarIdUsuario {

  static PegarIdUsuario? _pegarIdUsuario;

  static PegarIdUsuario get getInstance{
    _pegarIdUsuario ??= PegarIdUsuario(userAuthServiceIMP: FirebaseAuthService.getInstance);
    return _pegarIdUsuario!; 
  }

  PegarIdUsuario({required this.userAuthServiceIMP});

  final IUserAuthService userAuthServiceIMP;


  String pegar() => userAuthServiceIMP.currentUser;

}