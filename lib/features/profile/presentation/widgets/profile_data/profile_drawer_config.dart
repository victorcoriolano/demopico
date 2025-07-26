import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/about_page_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/drawer_item.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyCustomDrawer extends StatefulWidget {
  final UserM user;
  const MyCustomDrawer({super.key, required this.user});

  @override
  State<MyCustomDrawer> createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
  bool isEditing = false;

  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Tem certeza que deseja sair da sua conta?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            TextButton(
              child: const Text('Sair'),
              onPressed: () async {
                await context.read<AuthUserProvider>().logout();
                Get.offAll(
                  () => const HomePage(),
                  transition: Transition.rightToLeftWithFade,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kRed,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
                widget.user.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              
            accountEmail: Text(
              widget.user.email,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            currentAccountPicture: Row(
              children: [
                CircleAvatar(
                  
                  backgroundImage: widget.user.pictureUrl != null
                      ? NetworkImage(widget.user.pictureUrl!)
                      : AssetImage("assets/images/userPhoto.png") as ImageProvider,
                ),
              ],
            ),
            decoration: const BoxDecoration(
              color: kRed,
            ),
            // Adiciona a seta de voltar na parte superior direita do cabeçalho
            arrowColor: Colors.white, // Define a cor da seta
            otherAccountsPictures: [
              IconButton(
                icon: const Icon(Icons.chevron_left,
                    color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context); // Fecha o drawer
                },
              ),
            ],
          ),
          // Itens do menu
          DrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () {
              Get.to((_) => HomePage());
            },
          ),
          DrawerItem(
            icon: Icons.edit,
            text: 'Editar Perfil',
            onTap: () {
              Get.to(() => EditProfilePage(user: widget.user,));
            },
          ),
          DrawerItem(
            icon: Icons.map_outlined,
            text: 'Acessar o mapa',
            onTap: () {
              Get.to((_) => MapPage());
            },
          ),
          DrawerItem(
            icon: Icons.search,
            text: 'Pesquisar',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerItem(
            icon: Icons.notifications,
            text: 'Notificações',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(color: Colors.white54),
          DrawerItem(
            icon: Icons.logout,
            text: 'Log Out',
            onTap: () {
              logout(context);
            },
          ),
          DrawerItem(
            icon: Icons.info_outline,
            text: 'Sobre o App',
            onTap: () {
              // TODO: RESOLVER ERRO DE NAVEGAR PARA ABOUT PAGE
              Get.to((_) => AboutPage());
            },
          ),
        ],
      ),
    );
  }
}
