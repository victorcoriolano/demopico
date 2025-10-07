import 'package:demopico/features/profile/presentation/pages/chat_room_page.dart';
import 'package:demopico/features/profile/presentation/pages/my_profile_page.dart';
import 'package:demopico/features/profile/presentation/pages/search_profile_page.dart';
import 'package:demopico/features/profile/presentation/view_model/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_navigator_widget.dart';


class ScreensProfile extends StatelessWidget {
  const ScreensProfile({super.key});

  final List<Widget> _pages = const [
    ProfilePage(),
    SearchProfilePage(),
    ChatRoomPage(),
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
