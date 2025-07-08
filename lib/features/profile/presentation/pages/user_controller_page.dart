import 'package:demopico/features/profile/presentation/pages/profile_page.dart';
import 'package:demopico/features/profile/presentation/provider/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_navigator_widget.dart';


class UserControllerPage extends StatelessWidget {
  const UserControllerPage({super.key});

  final List<Widget> _pages = const [
    ProfilePage(),
    Center(child: Text('Procurar')),
    Center(child: Text('Página Mensagens')),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<ScreenProvider>().currentIndex;

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: const ProfileNavigatorWidget(),
    );
  }
}
