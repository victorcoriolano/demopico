import 'dart:async';

import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/usecases/listar_comunicados_uc.dart';
import 'package:demopico/features/hub/domain/usecases/postar_comunicado_uc.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:get/get.dart' show ExtensionSnackbar, Get;

class HubProvider extends ChangeNotifier {
  static HubProvider? _hubProvider;

  static HubProvider get getInstance {
    _hubProvider ??= HubProvider(
        postarComunicado: PostarComunicado.getInstance,
        listarComunicado: ListarComunicado.getInstance);
    return _hubProvider!;
  }

  PostarComunicado postarComunicado;
  ListarComunicado listarComunicado;
  HubProvider({required this.postarComunicado, required this.listarComunicado});

  List<Communique> _allCommuniques = [];

  List<Communique> get allCommuniques => _allCommuniques;

  StreamSubscription? _watcher;

  Future<void> postHubCommunique(String text, TypeCommunique type, UserM user, String server) async {
    try {
      await postarComunicado.postar(Communique.initial(text, type, user, server));
    } on Failure catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível postar o comunicado: ${e.message}',
        backgroundColor: Colors.red,
        colorText: Colors.black,
      );
    }
  }

  void watchCommuniques(String server, String collectionPath) async {
      _watcher = listarComunicado.listar(server,collectionPath).listen((allCommuniquesFromDb) {
        _allCommuniques = allCommuniquesFromDb.toList();
        notifyListeners();
      }, onError: (error) {
        debugPrint(error.toString());
        Get.snackbar(
          'Erro',
          'Não foi possível listar os comunicados',
          backgroundColor: Colors.red,
          colorText: Colors.black,
        );
      });
      notifyListeners(); 
  }

  @override
  void dispose() {
    _watcher?.cancel();
    super.dispose();
  }
}
