import 'package:demopico/features/profile/presentation/view_model/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileNavigatorWidget extends StatefulWidget {
  const ProfileNavigatorWidget({super.key});

  @override
  State<ProfileNavigatorWidget> createState() =>
      _ProfileNavigatorWidgetState();
}

class _ProfileNavigatorWidgetState extends State<ProfileNavigatorWidget> {
  @override
  Widget build(BuildContext context) {
      final navigatorProvider = context.watch<ScreenProvider>();
    return SizedBox( // <- controla o tamanho do scaffold (opcional)
      height: 60, 
      child:  BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: navigatorProvider.currentIndex,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedIconTheme: const IconThemeData(size: 25),
          onTap: (index) => navigatorProvider.setIndex(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
              activeIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 139, 0, 0),
                  ),
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
              activeIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 139, 0, 0),
                  ),
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Mensagens',
              activeIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat,
                    color: Color.fromARGB(255, 139, 0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
