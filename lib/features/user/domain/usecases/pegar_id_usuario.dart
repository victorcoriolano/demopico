import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_auth_firebase_service.dart';


class PegarIdUsuario {

  static PegarIdUsuario? _pegarIdUsuario;

  static PegarIdUsuario get getInstance{
    _pegarIdUsuario ??= PegarIdUsuario(userAuthServiceIMP: UserAuthFirebaseService.getInstance);
    return _pegarIdUsuario!; 
  }

  PegarIdUsuario({required this.userAuthServiceIMP});

  final IUserAuthService userAuthServiceIMP;


  String pegar() => userAuthServiceIMP.currentUser;

}