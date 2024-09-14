import 'package:demopico/features/user/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:demopico/features/user/presentation/pages/register_page.dart';
import 'package:demopico/features/user/presentation/widgets/button_custom.dart';
import 'package:demopico/features/user/presentation/widgets/textfield_decoration.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  final LoginController loginController;
  const LoginForm({super.key, required this.loginController});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _vulgoController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

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
                  image: AssetImage('assets/logo_skatepico2.png'),
                )),
            const SizedBox(
              height: 30,
            ),

            const Text(
              "Bem vindo de volta",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 30,
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
              validator: (value) {
                loginTry(value);
                return null;
              },
            ),

            const SizedBox(
              height: 30,
            ),
            //senha
            TextFormField(
              decoration: customTextField("Senha"),
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              controller: _senhaController,
              validator: (value) {
                loginTry(value);
                return null;
              },
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
              onPressed: () {
                setState(() {
                  if (FormFieldValidator.toString().isNotEmpty ||
                      _vulgoController.text.isNotEmpty &&
                          _senhaController.text.isNotEmpty) {
                    String vulgo = _vulgoController.text;
                    String password = _senhaController.text;
                    _vulgoController.text.contains("@")
                        ? widget.loginController
                            .loginByEmail(email: vulgo, password: password)
                        : widget.loginController
                            .loginByVulgo(vulgo: vulgo, password: password);
                  } else {
                    loginTry(FormFieldValidator.toString());
                  }
                });
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
}
