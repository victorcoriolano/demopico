import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:demopico/features/user/domain/usecases/pegar_dados_user_uc.dart';

class UserDatabaseProvider extends ChangeNotifier {

  static UserDatabaseProvider? _userDatabaseProvider;
  static UserDatabaseProvider get getInstance {
    _userDatabaseProvider ??= UserDatabaseProvider(pegarDadosUserUc: PegarDadosUserUc.getInstance);
    return _userDatabaseProvider!;
  }

  UserDatabaseProvider({required this.pegarDadosUserUc});

  final PegarDadosUserUc pegarDadosUserUc;

  String? errorMessage;
  UserM? _user;
  UserM? get user => _user;

  Future<void> retrieveUserProfileData(String uid) async {
    try{
      // Retorna se os dados já foram pegos 
      if (_user != null ) {
        debugPrint("Retornando por que os dados do user já foram pegos");
        return;
      }
      debugPrint("pegando dados do usuario");
      _user = await pegarDadosUserUc.getDados(uid);
    }catch (e) {
      debugPrint("erro ao pegar dados do usuario: $e");
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void setUser(UserM user){
    _user = user;
    notifyListeners();
  }


  // Future<void> updateUserBio(String newBio) async {
  //   final success = await AtualizarBioUserUc.getInstance.updateBio(_user!.id!, newBio);
  //   if (success) {
  //     _user!.description = newBio;
  //     notifyListeners();
  //   }
  // }
}
