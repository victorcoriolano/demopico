import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/app/home_page.dart';
import 'package:demopico/features/hub/presentation/pages/hub_page.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/user/data/external/firebase_auth.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:demopico/features/user/data/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthService>().firebaseService.authState,
            initialData: null),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DemoPico!',
        theme: ThemeData(
          // This is the theme of your application.
          // TRY THIS: changing the seedColor in the colorScheme below
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 139, 0, 0)),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const HomePage(),
          '/hub': (context) => const HubPage(),
          '/map': (context) => const MapPage(),
        },
      ),
    );
  }
}
