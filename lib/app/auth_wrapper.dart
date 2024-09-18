import 'package:demopico/features/profile/presentation/pages/user_page.dart';
import 'package:demopico/features/user/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    final User? user = context.watch<User?>();
    return user == null ? const LoginPage() : const UserPage();
  }
}
