import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class ControllerHomePage extends ChangeNotifier { 

  static ControllerHomePage? _instance;
  static ControllerHomePage get instance => _instance ??= ControllerHomePage(repository: UserDataRepositoryImpl.getInstance);

  final IUserDataRepository _repository;
  ControllerHomePage({required IUserDataRepository repository}): _repository = repository;

  int currentPage = 1;

  // Controlador do PageView, gerenciado pelo GetX.
  PageController? pageController;

  void initialize() {
    if (pageController != null) return;
    pageController = PageController(initialPage: currentPage, viewportFraction: 1.0);
  }

  // Método para lidar com a mudança de página no PageView.
  void onPageChanged(int index) {
    currentPage = index;
    notifyListeners();
  }

  // Lógica para lidar com o PopScope.
  Future<bool> handlePop() async {
    // Se estiver na página central, permite o pop padrão (sair do app).
    if (currentPage == 1) {
      return true;
    }

     await pageController?.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    return false;
  }
  
  // Método para verificar e redirecionar se o usuário não está autenticado
  void checkAuthAndNavigate(String routeName) {
    if (_repository.localUser == null ) {
      Get.toNamed(Paths.login);
    } else {
      Get.toNamed(routeName);
    }
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

}