import 'package:demopico/infra/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/hub': (context) => const HomePage(),
        '/map': (context) => const HomePage(),
        '/chat': (context) => const HomePage(),
        '/profile': (context) => const HomePage(),
      },
      title: 'DemoPico!',
      theme: ThemeData(
        // This is the theme of your application.
        // TRY THIS: changing the seedColor in the colorScheme below
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 139, 0, 0)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
