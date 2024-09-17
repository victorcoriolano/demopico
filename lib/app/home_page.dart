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
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: _currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: _currentPage == 0 
              ? const NeverScrollableScrollPhysics() // Desativar rolagem na página do mapa
              : const BouncingScrollPhysics(), // Habilitar rolagem nas outras páginas
          onPageChanged: (value) {
            setState(() {
              _currentPage = value;
            });
            log('$value');
          },
          controller: _pageController,
          children: [
            const MapPage(),
            CentralPage(),
            const UserPage(),
          ],
        ),
      ),
    );
  }
}