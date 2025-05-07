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


  UserM? _user;
  UserM? get user => _user;

  Future<void> retrieveUserProfileData(String uid) async {
    _user = await PegarDadosUserUc.getInstance.getDados(uid);
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
