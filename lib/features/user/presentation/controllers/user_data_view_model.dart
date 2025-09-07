import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:demopico/features/user/domain/usecases/pegar_dados_user_uc.dart';

class UserDataViewModel extends ChangeNotifier {

  static UserDataViewModel? _userDatabaseProvider;
  static UserDataViewModel get getInstance {
    _userDatabaseProvider ??= UserDataViewModel(pegarDadosUserUc: PegarDadosUserUc.getInstance);
    return _userDatabaseProvider!;
  }

  UserDataViewModel({required this.pegarDadosUserUc});

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

  set setUser(UserM? authUser){
    _user = authUser;
  }


  // Future<void> updateUserBio(String newBio) async {
  //   final success = await AtualizarBioUserUc.getInstance.updateBio(_user!.id!, newBio);
  //   if (success) {
  //     _user!.description = newBio;
  //     notifyListeners();
  //   }
  // }
}
