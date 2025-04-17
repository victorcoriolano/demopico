import 'package:demopico/features/hub/domain/usecases/postarComunicado_uc.dart';
import 'package:demopico/features/hub/infra/services/hubService.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:flutter/material.dart';

class HubProvider extends ChangeNotifier {
   PostarComunicado postarComunicado; 

  HubProvider({required this.postarComunicado, required this.});

  void notify() {
    notifyListeners();
  }

  List<Communique> _allCommuniques = [];

  List<Communique> get allCommuniques => _allCommuniques;

  Future<void> postHubCommunique(String text, String type) async {
    await postarComunicado.postar(text, type);
    getAllCommuniques();
  }

  Future<void> getAllCommuniques() async {
    final allCommuniquesFromDb = await hubService.getAllCommuniques();
    _allCommuniques = allCommuniquesFromDb;
    notifyListeners();
  }
}
