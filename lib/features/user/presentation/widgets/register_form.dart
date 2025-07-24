

import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/widgets/button_custom.dart';
import 'package:demopico/features/user/presentation/widgets/tipo_conta_dropdown.dart';
import 'package:demopico/features/user/presentation/widgets/textfield_decoration.dart';
import 'package:demopico/features/user/presentation/widgets/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      autovalidateMode: AutovalidateMode.disabled,
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
                Consumer<AuthUserProvider>(
                  builder: (context, provider, child) {
                    return TextFormField(
                      decoration: customTextField("Vulgo"),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      controller: _vulgoCadastro,
                      validator: (value) => provider.errorMessageVulgo ?? combineValidators([
                        () => isNotEmpty(value),
                        () => isValidVulgo(value),
                      ]),
                      onChanged: (value) => provider.clearMessageErrors(),
                    );
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                //email
                Consumer<AuthUserProvider>(
                  builder: (context, provider, child) {
                    return TextFormField(
                      decoration: customTextField("Email"),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      controller: _emailController,
                      validator: (value) {
                        return provider.errorMessageEmail ?? combineValidators([
                          () => isNotEmpty(value),
                          () => isValidEmail(value),
                        ]);
                        
                      },
                      onChanged: (value) =>  provider.clearMessageErrors(),
                    );
                  }
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
                Consumer<AuthUserProvider>(
                  builder: (context, provider, child) {
                    return ElevatedButton(
                      onPressed:  provider.isLoading ? null : () async {
                        if(_formkey.currentState?.validate() ?? false){
                          final credentialsSignUp = UserCredentialsSignUp(
                            password: _senhaController.text.trim(), 
                            uid: "", 
                            nome: _vulgoCadastro.text.trim(), 
                            isColetivo: isColetivo,
                            email: _emailController.text.trim());
                          await provider.signUp(credentialsSignUp);
                          _formkey.currentState?.validate();  /// validando formulário para mostrar a 
                                                              ///mensagem de erro no campo específico do erro
                        }
                      },
                      style: buttonStyle(),
                      child: provider.isLoading
                                ? const Center(child: CircularProgressIndicator(color: kWhite,),)
                                : const Text("Cadastrar"),
                    );
                  }
                ),
              ],
            ),
          ),
        ));
  }
}
