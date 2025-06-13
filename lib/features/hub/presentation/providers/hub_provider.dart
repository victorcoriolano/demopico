import 'package:demopico/core/app/auth_wrapper.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/usecases/listar_comunicados_uc.dart';
import 'package:demopico/features/hub/domain/usecases/postar_comunicado_uc.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation;

class HubProvider extends ChangeNotifier {

  static HubProvider? _hubProvider;

  static HubProvider get getInstance{
    _hubProvider ??= HubProvider(postarComunicado: PostarComunicado.getInstance, listarComunicado: ListarComunicado.getInstance);
    return _hubProvider!;
  }

  PostarComunicado postarComunicado;
  ListarComunicado listarComunicado;
  HubProvider({required this.postarComunicado, required this.listarComunicado});
  
  List<Communique> _allCommuniques = [];

  List<Communique> get allCommuniques => _allCommuniques;

  Future<void> postHubCommunique(String text, String type) async {
    try {
      await postarComunicado.postar(text, type);
      getAllCommuniques();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e is FormatException) {
        Get.snackbar(
          'Erro',
          e.message,
          backgroundColor: Colors.red,
          colorText: Colors.black,
        );
      } else if (e is FirebaseAuthException) {
        Get.snackbar(
          'Erro',
          e.message ?? 'Erro desconhecido',
          backgroundColor: Colors.red,
          colorText: Colors.black,
        );
        Future.delayed(const Duration(seconds: 2), () {
          Get.to(const AuthWrapper());
        });
      }
      Get.snackbar(
        'Erro',
        'Não foi possível postar o comunicado',
        backgroundColor: Colors.red,
        colorText: Colors.black,
      );
    }
  }

  Future<void> getAllCommuniques() async {
    try {
      final allCommuniquesFromDb = await listarComunicado.listar();
      _allCommuniques = allCommuniquesFromDb.nonNulls.toList();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar(
        'Erro',
        'Não foi possível listar os comunicados',
        backgroundColor: Colors.red,
        colorText: Colors.black,
      );
    }
  }
}
