import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/about_page_widget.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfileConfigureWidget extends StatefulWidget {
  final TextEditingController bioController;
  const ProfileConfigureWidget({
    super.key,
    required this.bioController,
  });

  @override
  State<ProfileConfigureWidget> createState() => _ProfileConfigureWidgetState();
}

class _ProfileConfigureWidgetState extends State<ProfileConfigureWidget> {
  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Configurações',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            height: 200,
            width: 100,
            child: ListView(
              shrinkWrap: true,
              itemExtent: 50,
              children: [
                ListTile(
                  title: const Text('Sobre o Aplicativo'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutPage()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Fazer Logout'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Tem certeza que deseja sair da sua conta?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancelar',
                                style:
                                    TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Voltar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: const Icon(Icons.settings),
        iconSize: 30,
        color: const Color.fromARGB(255, 0, 0, 0),
        onPressed: _showSettingsDialog,
      ),
    );
  }
}
