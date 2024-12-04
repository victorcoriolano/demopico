import 'package:demopico/app/app.dart';
import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:demopico/features/user/presentation/controllers/database_notifier_provider.dart';
import 'package:demopico/features/user/presentation/controllers/edit_profile.dart';
import 'package:demopico/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();


  runApp(
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EditProfileProvider()),
        ChangeNotifierProvider(create: (context) => DatabaseProvider()),
      ],
      child: const MyAppWidget(),
    ),);
  
}
