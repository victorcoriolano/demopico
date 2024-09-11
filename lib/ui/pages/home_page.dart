import 'dart:developer';

import 'package:demopico/ui/pages/central_page.dart';
import 'package:demopico/ui/pages/map_page.dart';
import 'package:demopico/ui/pages/user_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//
        body: SafeArea(
      child: PageView(
        onPageChanged: (value) {
          log('$value');
        },
        controller: _pageController,
        children: [
          const MapPage(),
          CentralPage(),
          const UserPage(),
        ],
      ),
    ));
  }
}
