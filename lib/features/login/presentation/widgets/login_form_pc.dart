import 'package:flutter/material.dart';
import 'package:demopico/features/login/presentation/pages/register_page.dart';
import 'package:demopico/features/login/presentation/widgets/button_custom.dart';
import 'package:demopico/features/login/presentation/widgets/textfield_custom.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

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
                if (value == null || value.isEmpty) {
                  return "Campo obrigatório";
                } else {
                  return null;
                }
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
                  if (FormFieldValidator.toString().isEmpty) {
                    print("OK!!!!");
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
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
