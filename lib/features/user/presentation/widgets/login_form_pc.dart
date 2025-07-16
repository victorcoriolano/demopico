
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
                onPressed: () {
                  //TODO: IMPLEMENTAR LÓGICA DE ESQUECEU A SENHA 
                },
                child: const Text(
                  "Esqueceu senha",
                  style: TextStyle(color: Color.fromARGB(255, 189, 198, 214)),
                )),

            
            const SizedBox(
              height: 12,
            ),

            // button (entrar)
            ElevatedButton(
              onPressed: () async {
                
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

}
