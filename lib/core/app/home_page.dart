// home_page.dart
import 'package:demopico/core/app/auth_wrapper.dart';
import 'package:demopico/core/app/controller/controller_home_page.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/home/presentation/pages/central_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    context.read<ControllerHomePage>().initialize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ControllerHomePage>(
          builder: (contex, controller, child) {
            return PopScope(
              canPop: controller.currentPage == 1,
              onPopInvokedWithResult: (didPop, value) async {
                if (!didPop) {
                  await controller.handlePop();
                }
              },
              child: PageView(
                physics: controller.currentPage == 0
                    ? const NeverScrollableScrollPhysics() // Desativa a rolagem no mapa
                    : const BouncingScrollPhysics(),
                onPageChanged: controller.onPageChanged,
                controller: controller.pageController ,
                children: const [
                  MapPage(),
                  CentralPage(),
                  AuthWrapper(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
