import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
import 'package:demopico/features/user/presentation/controllers/user_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserDataViewModel>().user;

    return Drawer(
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
                if (user == null){
                  Get.snackbar("Erro", "Usuário não logado faça login para acessar seus picos", colorText: kWhite);
                  Get.toNamed(Paths.login);
                  return;
                }
                
                else {
                  // FIXME: PASSANDO O NOME AO INVÉS DE PASSAR O ID Pq nossa infra n tem o id
                  Get.toNamed(Paths.mySpots, arguments: user.name);
                }
              },),
            MenuItem(
                  icon: Icons.bookmark, 
                  text: 'PICOS SALVOS', 
                  onPressed: () {
                    if(user == null){
                      Get.snackbar("Usuário não logado", "Faça login para acessar seus picos salvos",
                      showProgressIndicator: true, 
                      onTap: (snackbar) {
                        Get.toNamed(Paths.login);
                      });
                      return;
                    }
                    final userId = user.id; 
                    Get.toNamed(Paths.favoriteSpot, arguments: userId);
                  },
                ),
              
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
    );
  }

  
}

class MenuItem extends StatelessWidget {
  final IconData icon; // Ícone do item
  final String text; // Texto do item
  final VoidCallback onPressed; // Função a ser chamada ao pressionar o item

  // Construtor do MenuItem
  const MenuItem({super.key, 
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kRed), // Ícone do item
      title: Text(text,
          style:
              const TextStyle(color: kBlack)), // Texto do item em preto
      onTap: onPressed, // Ação a ser realizada ao pressionar o item
    );
  }
}
