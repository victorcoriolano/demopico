import 'package:demopico/app/app.dart';
import 'package:demopico/features/user/presentation/controllers/inject_dependencies.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyAppWidget());
}
