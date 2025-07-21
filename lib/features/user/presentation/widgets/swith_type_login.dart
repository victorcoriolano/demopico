import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwithTypeLogin extends StatefulWidget {
  const SwithTypeLogin({super.key});

  @override
  State<SwithTypeLogin> createState() => _SwithTypeLoginState();
}

class _SwithTypeLoginState extends State<SwithTypeLogin> {
  

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthUserProvider>(
      builder: (context, provider, child) => Column(
        children: [
          Switch(
            thumbIcon: WidgetStatePropertyAll(Icon(Icons.skateboarding)),
            
            value: provider.isEmail, 
            onChanged: (value) => provider.changeIsEmail()
          ),
          Text("Entrar com ${provider.identifier.name}", style: TextStyle(color: kWhite),),
        ],
      ),
    );
  }
}