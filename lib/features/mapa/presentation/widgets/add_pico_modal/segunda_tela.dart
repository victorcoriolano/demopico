import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SegundaTela extends StatefulWidget {
  const SegundaTela({super.key});

  @override
  _SegundaTelaState createState() => _SegundaTelaState();
}

class _SegundaTelaState extends State<SegundaTela> {
  // Variáveis para armazenar a avaliação de cada atributo (0 a 5)
/*   Map<String, int> atributos = {
    'Chão': 4,
    'Iluminação': 3,
    'Policiamento': 4,
    'Movimento': 3,
    'Kick-Out': 4,
  };

  // Função para definir o valor de cada atributo
  void setAtributo(String atributo, int valor) {
    setState(() {
      atributos[atributo] = valor; // Atualiza o valor do atributo selecionado
    });
  } */

  @override
  Widget build(BuildContext context) {

    return Consumer<AddPicoControllerProvider>(
      builder: (context, provider, child) => 
      Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
        
              child: SingleChildScrollView(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Imagem no topo
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Image.asset('assets/images/progresso2.png', ),
                        ),
                      ),
      
                    // Widget de cada atributo com descrição abaixo dos ícones
                    buildAtributo(
                      'Chão',
                      'Liso / Plaza',
                      provider.atributos['Chão']!,
                      (valor) => provider.atualizarAtributo('Chão', valor),
                    ),
                    buildAtributo(
                      'Iluminação',
                      'Clarinho',
                      provider.atributos['Iluminação']!,
                      (valor) => provider.atualizarAtributo('Iluminação', valor),
                    ),
                    buildAtributo(
                      'Policiamento',
                      'Paloso',
                      provider.atributos['Policiamento']!,
                      (valor) => provider.atualizarAtributo('Policiamento', valor),
                    ),
                    buildAtributo(
                      'Movimento',
                      'Cheio',
                      provider.atributos['Movimento']!,
                      (valor) => provider.atualizarAtributo('Movimento', valor),
                    ),
                    buildAtributo(
                      'Kick-Out',
                      'Bem Capaz',
                      provider.atributos['Kick-Out']!,
                      (valor) => provider.atualizarAtributo('Kick-Out', valor),
                    ),
                  ],
                ),
              ),
            )
      ),
    );
  }

  // Widget para construir cada linha de atributo
  Widget buildAtributo(String titulo, String descricao, int valor, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os itens
      children: [
        // Nome do atributo
        Text(
          '$titulo:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),

        // Avaliação por imagens customizadas
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza os ícones
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.all(0.0), // Ajustado para um espaçamento menor
              child: IconButton(
                icon: Image.asset(
                  height: 60.0,// diminuindo o tamanho do icon para n ficar dando erro
                  width: 45.0,
                'assets/images/iconPico.png', // Substitua pelo caminho da sua imagem
                  color: index < valor ? const Color(0xFF8B0000) : Colors.grey[350], // Altera a cor do ícone baseado na avaliação
                ),
                iconSize: 5, // Tamanho aumentado para 50
                onPressed: () {
                  onChanged(index + 1); // Atualiza o valor do atributo
                } 
              ),
            );
          }),
        ),

        // Descrição abaixo dos ícones
        Text(
          descricao,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),

        const SizedBox(height: 7),
      ],
    );
  }
}
