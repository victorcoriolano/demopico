import 'package:flutter/material.dart';

class ProfileNavigatorWidget extends StatefulWidget {
  const ProfileNavigatorWidget({super.key});

  @override
  State<ProfileNavigatorWidget> createState() =>
      _ProfileNavigatorWidgetState();
}

class _ProfileNavigatorWidgetState extends State<ProfileNavigatorWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox( // <- controla o tamanho do scaffold (opcional)
      height: 60, 
      child:  BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedIconTheme: const IconThemeData(size: 25),
          
    
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
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
