import 'dart:developer';

import 'package:demopico/app/auth_wrapper.dart';
import 'package:demopico/features/home/presentation/pages/central_page.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
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
        body: SafeArea(
      child: PageView(
        onPageChanged: (value) {
          log('$value');
        },
        controller: _pageController,
        children: [const MapPage(), CentralPage(), const AuthWrapper()],
      ),
    ));
  }
}