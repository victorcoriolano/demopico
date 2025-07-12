import 'dart:developer';

import 'package:demopico/core/app/auth_wrapper.dart';
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
  int _currentPage = 1; // Inicia na CentralPage (index 1)

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
        // Envolve o PageView com PopScope
        child: PopScope(
          // canPop: true se estiver na página central, permitindo o pop padrão (fechar app/voltar rota)
          // canPop: false se não estiver, interceptando o pop
          canPop: _currentPage == 1,
          onPopInvokedWithResult: (bool didPop, Object? result) {
            // 'didPop' é true se a rota foi realmente "popada" (se canPop era true e o pop ocorreu).
            // Se 'didPop' for false, significa que o pop foi impedido por 'canPop: false'.
            if (!didPop) {
              // Se o pop foi impedido (porque não estamos na página central),
              // então animamos para a CentralPage (index 1).
              if (_currentPage != 1) {
                _pageController.animateToPage(
                  1, // Ir para a CentralPage
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
              // Se _currentPage já é 1, e canPop era true, então 'didPop' seria true,
              // e este bloco não seria executado, permitindo o pop padrão (saída do app).
            }
          },
          child: PageView(
            physics: _currentPage == 0
                ? const NeverScrollableScrollPhysics() // Desativa rolagem na página do mapa (index 0)
                : const BouncingScrollPhysics(), // Permite rolagem nas outras páginas
            onPageChanged: (value) {
              setState(() {
                _currentPage = value; // Atualiza o índice da página atual
              });
              log('Página atual: $value');
            },
            controller: _pageController,
            children: const [
              MapPage(),
              CentralPage(),
              AuthWrapper(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}