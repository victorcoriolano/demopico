import 'package:demopico/features/login/presentation/widgets/button_custom.dart';
import 'package:demopico/features/login/presentation/widgets/dropdown.dart';
import 'package:demopico/features/login/presentation/widgets/textfield_custom.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _vulgoCadastro = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  String _tipoConta = '';

  void _onTipoContaChanged(String newValue) {
    setState(() {
      _tipoConta = newValue;
    });
    // Faça algo com o valor selecionado, por exemplo, enviar para um servidor
  }

  

 
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
                )
              ),
              const SizedBox(height: 20,),
              
              const Text(
                "Bem vindo ao PICO!",
                style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 30,),
              ),
              const SizedBox(height: 20,),

              // vulgo
              TextFormField( 
                decoration: customTextField("Vulgo"),
                cursorColor: Colors.white, 
                style: const TextStyle(
                  color: Colors.white
                ),
                controller: _vulgoCadastro,
                validator: (value){},
              ),

              const SizedBox(height: 20,),
              //email
              TextFormField( 
                decoration: customTextField("Email"),
                cursorColor: Colors.white, 
                style: const TextStyle(
                  color: Colors.white
                ),
                controller: _emailController,
                validator: (value){},
              ),

              const SizedBox(height: 20,),
              //senha
              TextFormField(
                decoration: customTextField("Senha"),
                cursorColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white
                ),
                obscureText: true,
                controller: _senhaController,
                validator: (value){},
              ),
              const SizedBox(height: 20,),

              // confirmar senha 
              TextFormField(
                decoration: customTextField("Confirmar senha "),
                cursorColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white
                ),
                obscureText: true,
                controller: _senhaController,
                validator: (value){},
              ),
              const SizedBox(height: 20,),
              //tipo de onta
              TipoContaDropdownButton(onChanged: _onTipoContaChanged),
              const SizedBox(height: 12,),
          
              // button (cadastrar)
              ElevatedButton(
                onPressed: () {},
                style: buttonStyle(), 
                child: const Text(
                  "Cadastrar", 
                  style: TextStyle(
                    color: Colors.white
                  ),
                ), 
              ),
            ],
          ),
        ),
      )
    );
  }
}