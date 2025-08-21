// home_page.dart
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/features/home/presentation/pages/central_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
            key: const Key('home_page_gesture_detector_navigate'),
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Get.toNamed(Paths.map);

          } else if (details.primaryVelocity! < 0) {
            Get.toNamed(Paths.profile);
          }
        },
        child: CentralPage()
      ),
      ),
    );
  }
}
