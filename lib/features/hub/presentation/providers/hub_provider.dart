

import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/usecases/listar_comunicados_uc.dart';
import 'package:demopico/features/hub/domain/usecases/postar_comunicado_uc.dart';
import 'package:flutter/foundation.dart';

class HubProvider extends ChangeNotifier {
  PostarComunicado postarComunicado;
  ListarComunicado listarComunicado;
  HubProvider({required this.postarComunicado, required this.listarComunicado});
  
  List<Communique> _allCommuniques = [];

  List<Communique> get allCommuniques => _allCommuniques;

  Future<void> postHubCommunique(String text, String type) async {
    await postarComunicado.postar(text, type);
    getAllCommuniques();
  }

  Future<void> getAllCommuniques() async {
    final allCommuniquesFromDb = await listarComunicado.listar();
    _allCommuniques = allCommuniquesFromDb.nonNulls.toList();
    notifyListeners();
  }
}
