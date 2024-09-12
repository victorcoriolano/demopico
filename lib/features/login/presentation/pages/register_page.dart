import 'package:barna_chat/feature_auth/ui/register_form.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/containerCadastro.jpg'),
                fit: BoxFit.cover, 
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), // Ajuste a opacidade aqui
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,size: 40,),
              onPressed: () {
                Navigator.pop(context); // Navega para a tela anterior
              },
            ),
          ),
          const Center(
            child: RegisterForm(),
          ),
        ],
      ),  
    );
  }
}