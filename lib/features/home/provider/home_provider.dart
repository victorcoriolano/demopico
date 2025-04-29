import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/usecases/listar_comunicados_uc.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  ListarComunicado listarComunicado;
  HomeProvider({required this.listarComunicado});
  
    List<Communique?> _allCommuniques = [];

    List<Communique?> get allCommuniques  => _allCommuniques;

  Future<void> getAllCommuniques() async {
    final allCommuniquesFromDb = await listarComunicado.listar();
    _allCommuniques = allCommuniquesFromDb;
    notifyListeners();
  }

   
}