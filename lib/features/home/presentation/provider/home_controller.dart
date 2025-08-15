import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/usecases/listar_comunicados_uc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends ChangeNotifier {
  ListarComunicado listarComunicado;
  HomeController({required this.listarComunicado});
  
  static HomeController? _homeProvider;

  static HomeController get getInstance{
    _homeProvider ??= HomeController(listarComunicado: ListarComunicado.getInstance);
    return _homeProvider!;
  }

    List<Communique?> _allCommuniques = [];

    List<Communique?> get allCommuniques  => _allCommuniques;

  Future<void> getAllCommuniques() async {
    final allCommuniquesFromDb = await listarComunicado.listar();
    _allCommuniques = allCommuniquesFromDb;
    notifyListeners();
  }


  void swipeRight() {
    Get.toNamed(Paths.map);
  }

  void swipeLeft() {
    Get.toNamed(Paths.profile);
  }
}