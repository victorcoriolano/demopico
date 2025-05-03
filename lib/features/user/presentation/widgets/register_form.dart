import 'package:demopico/features/profile/presentation/pages/user_page.dart';
import 'package:demopico/features/user/presentation/controllers/auth_controller.dart';

import 'package:demopico/features/user/presentation/widgets/button_custom.dart';
import 'package:demopico/features/user/presentation/widgets/tipo_conta_dropdown.dart';
import 'package:demopico/features/user/presentation/widgets/textfield_decoration.dart';
import 'package:demopico/features/user/presentation/widgets/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with Validators {
  final TextEditingController _vulgoCadastro = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _senhaController2 = TextEditingController();
  final AuthController _controller = AuthController();
  final _formkey = GlobalKey<FormState>();
  String _tipoConta = '';
  bool isColetivo = false;

  bool _onTipoContaChanged(String newValue) {
    setState(() {
      _tipoConta = newValue;
    });
    if (_tipoConta.contains('Coletivo')) {
      setState(() {
        isColetivo = true;
      });
    } else {
      setState(() {
        isColetivo = false;
      });
    }
    return isColetivo;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
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
             
                const Text(
                  "Bem vindo ao PICO!",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                // vulgo
                TextFormField(
                  decoration: customTextField("Vulgo"),
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  controller: _vulgoCadastro,
                  validator: isNotEmpty,
                ),

                const SizedBox(
                  height: 20,
                ),
                //email
                TextFormField(
                  decoration: customTextField("Email"),
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  controller: _emailController,
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
                const SizedBox(
                  height: 20,
                ),

                // confirmar senha
                TextFormField(
                  decoration: customTextField("Confirmar senha "),
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  controller: _senhaController2,
                  validator: (value) => combineValidators([
                    () => isNotEmpty(value),
                    () => checkPassword(_senhaController.text, value),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                //tipo de onta
                TipoContaDropdownButton(
                    onChanged: (String newValue) =>
                        _onTipoContaChanged(newValue),
                    validator: (value) => isNotEmpty(value)),

                const SizedBox(
                  height: 12,
                ),

                // button (cadastrar)
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      String vulgo = _vulgoCadastro.text.trim();
                      String email = _emailController.text.trim();
                      String password = _senhaController.text.trim();
                      print('$email, $password, $vulgo, $isColetivo');
                      final resultadoRegistro = await _controller.signUp(
                          inputEmail: email,
                          inputPassword: password,
                          inputName: vulgo,
                          isColetivo: isColetivo);
                      print(resultadoRegistro);
                      if (resultadoRegistro == true) {
                        _vulgoCadastro.clear();
                        _emailController.clear();
                        _senhaController.clear();
                        _senhaController2.clear();
                        Get.to(() => const UserPage());
                      } else {
                        Get.snackbar('Erro', 'Falha ao registrar usuário');
                        print("deu mel");
                      }
                      // ir pra página de perfil se der tudo certo
                    }
                  },
                  style: buttonStyle(),
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
