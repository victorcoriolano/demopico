import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/widgets/snackbar_utils.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MapDrawer extends StatefulWidget {
  const MapDrawer({super.key});

  @override
  State<MapDrawer> createState() => _MapDrawerState();
}

class _MapDrawerState extends State<MapDrawer> {
  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthViewModelAccount>().authState;

    return SafeArea(
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MenuItem(
                icon: Icons.spoke,
                text: " MEUS PICOS",
                onPressed: () {
                  switch (authState) {
                    case AuthAuthenticated():
                      // FIXME: PASSANDO O NOME AO INVÉS DE PASSAR O ID Pq nossa infra n tem o id
                      Get.toNamed(Paths.mySpots,
                          arguments: authState.user.displayName.value);
                    case AuthUnauthenticated():
                      Get.snackbar("Erro",
                          "Usuário não logado faça login para acessar seus picos",
                          colorText: kWhite);
                      Get.toNamed(Paths.login);
                      return;
                  }
                },
              ),
              MenuItem(
                  icon: Icons.bookmark,
                  text: 'PICOS FAVORITOS',
                  onPressed: () {
                    switch (authState) {
                      case AuthAuthenticated():
                        // FIXME: PASSANDO O NOME AO INVÉS DE PASSAR O ID Pq nossa infra n tem o id
                        Get.toNamed(Paths.mySpots,
                            arguments: authState.user.id);
                      case AuthUnauthenticated():
                        SnackbarUtils.userNotLogged(context);
                        return;
                    }
                  }),

              Divider(),
              // Botão Configurar Mapa
              MenuItem(
                icon: Icons.map,
                text: 'CONFIGURAR MAPA',
                onPressed: () {
                  Get.back();
                  ModalHelper.abrirModalConfgMap(context);
                },
              ),

              // Botão Histórico
              MenuItem(
                icon: Icons.history, // Ícone para Histórico
                text: 'HISTÓRICO', // Texto do botão
                onPressed: () {
                  Get.toNamed(Paths.historySpot);
                },
              ),

              // Botão Home
              MenuItem(
                icon: Icons.home, // Ícone para Home
                text: 'HOME', // Texto do botão
                onPressed: () {
                  // Navega de volta para a tela inicial
                  Get.offAndToNamed(Paths.home);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon; // Ícone do item
  final String text; // Texto do item
  final VoidCallback onPressed; // Função a ser chamada ao pressionar o item

  // Construtor do MenuItem
  const MenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kRed), // Ícone do item
      title: Text(text,
          style: const TextStyle(color: kBlack)), // Texto do item em preto
      onTap: onPressed, // Ação a ser realizada ao pressionar o item
    );
  }
}
