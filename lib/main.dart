import 'package:demopico/app/app.dart';
import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:demopico/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MyAppWidget());
}
