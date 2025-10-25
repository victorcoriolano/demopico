import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/about_page_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/drawer_item.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyCustomDrawer extends StatefulWidget {
  final UserEntity user;
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
                await context.read<AuthViewModelAccount>().logout();
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
                widget.user.displayName.value,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              
            accountEmail: Text(
              widget.user.email.value,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            currentAccountPicture: Row(
              children: [
                CircleAvatar(
                  
                  backgroundImage: widget.user.avatar != null
                      ? NetworkImage(widget.user.avatar!)
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
                  Get.back(); // Fecha o drawer
                },
              ),
            ],
          ),
          // Itens do menu
          DrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () {
              Get.toNamed(Paths.home);
            },
          ),
          DrawerItem(
            icon: Icons.edit,
            text: 'Editar Perfil',
            onTap: () {
              Get.to(() => EditProfilePage(), arguments: widget.user);
            },
          ),
          DrawerItem(
            icon: Icons.map_outlined,
            text: 'Acessar o mapa',
            onTap: () {
              Get.toNamed(Paths.map);
            },
          ),
          DrawerItem(
            icon: Icons.search,
            text: 'Pesquisar',
            onTap: () {
              Get.back();
            },
          ),
          DrawerItem(
            icon: Icons.notifications,
            text: 'Notificações',
            onTap: () {
              Get.back();
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
              Get.toNamed(Paths.aboutPage);
            },
          ),
        ],
      ),
    );
  }
}
