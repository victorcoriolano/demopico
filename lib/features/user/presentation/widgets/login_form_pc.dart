import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/pages/register_page.dart';
import 'package:demopico/features/user/presentation/widgets/button_custom.dart';
import 'package:demopico/features/user/presentation/widgets/textfield_decoration.dart';
import 'package:demopico/features/user/presentation/widgets/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with Validators {
  final TextEditingController _vulgoController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final _authUserProvider = AuthUserProvider.getInstance;

  @override
  Widget build(BuildContext context) {
    return Form(
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
                color: Colors.white,
                fontSize: 25,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            //email ou vulgo
            TextFormField(
              decoration: customTextField("E-mail ou vulgo"),
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              controller: _vulgoController,
              validator: (value) => combineValidators([
                () => isNotEmpty(value),
                () => isValidEmail(value),
              ]),
            ),

            const SizedBox(
              height: 20,
            ),
            //senha
            TextFormField(
              decoration: customTextField("Senha"),
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              controller: _senhaController,
              validator: (value) => combineValidators([
                () => isNotEmpty(value),
                () => isValidPassword(value),
              ]),
            ),
            // text input(esqueceu senha)
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Esqueceu senha",
                  style: TextStyle(color: Color.fromARGB(255, 189, 198, 214)),
                )),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.adb),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.email_rounded),
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),

            // button (entrar)
            ElevatedButton(
              onPressed: () async {
                if (FormFieldValidator.toString().isNotEmpty ||
                    _vulgoController.text.isNotEmpty &&
                        _senhaController.text.isNotEmpty) {
                  String vulgo = _vulgoController.text.trim();
                  String password = _senhaController.text.trim();

                  bool loginSuccess;

                  try {
                    if (vulgo.contains("@")) {
                      UserCredentialsSignIn credential = UserCredentialsSignIn(
                          email: vulgo, password: password);
                      loginSuccess =
                          await _authUserProvider.loginEmail(credential);
                    } else {
                      UserCredentialsSignInVulgo credential =
                          UserCredentialsSignInVulgo(
                              vulgo: vulgo, password: password);

                      loginSuccess =
                          await _authUserProvider.loginVulgo(credential);
                    }
                  } catch (e) {
                    print("Erro ao fazer login: $e");
                    loginSuccess = false;
                  }
                  setState(() {
                    if (loginSuccess) {
                      Get.to(() => const HomePage());
                    } else {
                      showSnackbar(vulgo.contains("@") ? 'email' : 'user');
                    }
                  });
                } else {
                  showSnackbar('default');
                }
              },
              style: buttonStyle(),
              child: const Text(
                "Entrar",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            //button (fazer parte)
            ElevatedButton(
              onPressed: () {
                Get.to(() => const RegisterPage(),
                    transition: Transition.circularReveal,
                    duration: const Duration(seconds: 1));
              },
              style: buttonStyle(),
              child: const Text("FAZER PARTE",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ));
  }

  String loginTry(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obrigatório";
    } else {
      return value;
    }
  }

  void showSnackbar(errorType) {
    switch (errorType) {
      case 'email':
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(InvalidEmailFailure().message)));
      case 'user':
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(UserNotFoundFailure().message)));
      case 'default':
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(ServerFailure().message)));
    }
  }
}
