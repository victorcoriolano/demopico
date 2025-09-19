import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_sign_in.dart';
import 'package:demopico/features/user/presentation/widgets/button_custom.dart';
import 'package:demopico/features/user/presentation/widgets/swith_type_login.dart';
import 'package:demopico/features/user/presentation/widgets/textfield_decoration.dart';
import 'package:demopico/features/user/presentation/widgets/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with Validators {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(70.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    height: 200,
                    width: 250,
                    child: Image(
                      image: AssetImage('assets/images/skatepico-icon.png'),
                    )),

                const SizedBox(
                  height: 30,
                ),

                const Text(
                  "Bem vindo de volta",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: kWhite,
                    fontSize: 25,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                SwithTypeLogin(),

                const SizedBox(
                  height: 15,
                ),

                //email ou vulgo
                Consumer<AuthViewModelSignIn>(builder: (context, provider, child) {
                  return TextFormField(
                    onChanged: (value) => provider.login = value,
                    decoration: customTextField(provider.getHintToFieldLogin()),
                    cursorColor: kWhite,
                    style: const TextStyle(color: kWhite),
                    controller: _loginController,
                    validator: (value) => combineValidators([
                      () => isNotEmpty(value),
                    ]),
                  );
                }),

                const SizedBox(
                  height: 20,
                ),
                //senha
                Consumer<AuthViewModelSignIn>(
                  builder: (context, provider, child) {
                    return TextFormField(
                      onFieldSubmitted: (value) async {
                        await provider.signIn(); 
                      },
                      onChanged: (value) => provider.password = value,
                      decoration: customTextField("Senha"),
                      cursorColor: kWhite,
                      style: const TextStyle(color: kWhite),
                      obscureText: true,
                      controller: _senhaController,
                      validator: (value) => combineValidators([
                        () => isNotEmpty(value),
                        () => isValidPassword(value),
                      ]),
                    );
                  }
                ),
                // text input(esqueceu senha)
                TextButton(
                    onPressed: () {
                      //TODO: IMPLEMENTAR LÓGICA DE ESQUECEU A SENHA
                    },
                    child: const Text(
                      "Esqueceu senha",
                      style:
                          TextStyle(color: Color.fromARGB(255, 189, 198, 214)),
                    )),

                const SizedBox(
                  height: 12,
                ),

                // button (entrar)
                ElevatedButton(
                  onPressed: () async {
                    final viewModel = context.read<AuthViewModelSignIn>();
                    await viewModel.signIn(); 
                  },
                  style: buttonStyle(),
                  child: const Text(
                    "Entrar",
                    style: TextStyle(
                      color: kWhite,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                //button (fazer parte)
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(
                      Paths.signUp,
                    );
                  },
                  style: buttonStyle(),
                  child: const Text("FAZER PARTE",
                      style: TextStyle(color: kWhite)),
                ),
              ],
            ),
          ),
        ));
  }
}
