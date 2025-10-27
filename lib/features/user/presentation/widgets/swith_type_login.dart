import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_sign_in.dart';
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
    return Consumer<AuthViewModelSignIn>(
      builder: (context, provider, child) => Column(
        children: [
          Switch(
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Icon(Icons.email);
                  }
                  return const Icon(Icons.person);
                },
              ),
              value: provider.isEmail,
              onChanged: (value) => provider.changeIsCredential(value)),
          Text(
            "Entrando com ${provider.identifier.name}",
            style: TextStyle(color: kWhite),
          ),
        ],
      ),
    );
  }
}
