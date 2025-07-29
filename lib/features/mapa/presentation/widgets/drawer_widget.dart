import 'package:demopico/core/app/auth_wrapper.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/presentation/pages/historico_page.dart';
import 'package:demopico/features/mapa/presentation/pages/favorites_page.dart';
import 'package:demopico/features/mapa/presentation/pages/my_spots_page.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as devoloper;

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserDatabaseProvider>().user;

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
                  Get.to(() => AuthWrapper());
                  return;
                }
                
                else {
                  devoloper.log(
                    "PASSANDO O NAME MAIS DEVE PASSAR O ID",
                    name: 'DESENVOLVIMENTO.AVISO',
                    level: 900,
                  );
                  Get.to(() => MySpotsPage(idUser: user.name,));
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
                        Get.to(() => AuthWrapper());
                      });
                    }
                    final userId = user!.id; 
                    Get.to(() => FavoriteSpotPage(userID: userId));
                    
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
                Get.to(() => const HistoricoPage());
              },
            ),

            // Botão Home
            MenuItem(
              icon: Icons.home, // Ícone para Home
              text: 'HOME', // Texto do botão
              onPressed: () {
                // Navega de volta para a tela inicial
                Get.offAndToNamed('/');
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
