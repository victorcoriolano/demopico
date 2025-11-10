import 'package:demopico/core/app/app.dart';
import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:demopico/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  await init();

  runApp(const MyAppWidget());
  //
}