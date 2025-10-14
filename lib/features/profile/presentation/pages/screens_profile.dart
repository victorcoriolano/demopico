import 'package:demopico/features/profile/presentation/pages/chat_list_page.dart';
import 'package:demopico/features/profile/presentation/pages/my_profile_page.dart';
import 'package:demopico/features/profile/presentation/pages/search_profile_page.dart';
import 'package:demopico/features/profile/presentation/view_model/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_navigator_widget.dart';


class ScreensProfile extends StatefulWidget {
  const ScreensProfile({super.key,});

  @override
  State<ScreensProfile> createState() => _ScreensProfileState();
}

class _ScreensProfileState extends State<ScreensProfile> {


  @override
  Widget build(BuildContext context) {

      final List<Widget> pages = [
    MyProfilePage(),
    SearchProfilePage(),
    ChatListPage(),
  ];
    final currentIndex = context.watch<ScreenProvider>().currentIndex;

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: const ProfileNavigatorWidget(),
    );
  }
}
