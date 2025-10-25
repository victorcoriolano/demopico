

import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_sign_up.dart';
import 'package:demopico/features/user/presentation/widgets/button_custom.dart';
import 'package:demopico/features/user/presentation/widgets/textfield_decoration.dart';
import 'package:demopico/features/user/presentation/widgets/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                Consumer<AuthViewModelSignUp>(
                  builder: (context, provider, child) {
                    return TextFormField(
                      decoration: customTextFieldDecoration("Vulgo"),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      controller: _vulgoCadastro,
                      validator: (value) => provider.errorVulgo ?? combineValidators([
                        () => isNotEmpty(value),
                        () => isValidVulgo(value),
                      ]),
                      onChanged: (value) { 
                        provider.updateFieldVulgo(value);
                        provider.clearMessageErrors();}
                    );
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                //email
                Consumer<AuthViewModelSignUp>(
                  builder: (context, provider, child) {
                    return TextFormField(
                      decoration: customTextFieldDecoration("Email"),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      controller: _emailController,
                      validator: (value) {
                        return provider.errorEmail ?? combineValidators([
                          () => isNotEmpty(value),
                          () => isValidEmail(value),
                        ]);
                        
                      },
                      onChanged: (value) { 
                        provider.updateFieldEmail(value);
                        provider.clearMessageErrors();
                      }
                    );
                  }
                ),
    
                const SizedBox(
                  height: 20,
                ),
                //senha
                TextFormField(
                  decoration: customTextFieldDecoration("Senha"),
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
                Consumer<AuthViewModelSignUp>(
                  builder: (context, provider, child) {
                    return TextFormField(
                      decoration: customTextFieldDecoration("Confirmar senha "),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      controller: _senhaController2,
                      validator: (value) => combineValidators([
                        () => isNotEmpty(value),
                        () => checkPassword(_senhaController.text, value),
                      ]),
                      onChanged: (value) { 
                            provider.updateFieldPassword(value);
                            provider.clearMessageErrors();}
                    
                    );
                  }
                ),
                const SizedBox(
                  height: 12,
                ),
    
                // button (cadastrar)
                Consumer<AuthViewModelSignUp>(
                  builder: (context, provider, child) {
                    return ElevatedButton(
                      onPressed:  provider.isLoading ? null : () async {
                        if(_formkey.currentState?.validate() ?? false){
                          await provider.signUp();
                          if(mounted){
                            Get.back();
                          }
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
