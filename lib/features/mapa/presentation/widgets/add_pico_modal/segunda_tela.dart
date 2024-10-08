import 'package:flutter/material.dart';
import 'terceira_tela.dart'; // Importando a terceira tela

class SegundaTela extends StatefulWidget {
  @override
  _SegundaTelaState createState() => _SegundaTelaState();
}

class _SegundaTelaState extends State<SegundaTela> {
  // Variáveis para armazenar a avaliação de cada atributo (0 a 5)
  Map<String, int> atributos = {
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
  }

  @override
  Widget build(BuildContext context) {
    // Obter o tamanho da tela
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                    atributos['Chão']!,
                    (valor) => setAtributo('Chão', valor),
                  ),
                  buildAtributo(
                    'Iluminação',
                    'Clarinho',
                    atributos['Iluminação']!,
                    (valor) => setAtributo('Iluminação', valor),
                  ),
                  buildAtributo(
                    'Policiamento',
                    'Paloso',
                    atributos['Policiamento']!,
                    (valor) => setAtributo('Policiamento', valor),
                  ),
                  buildAtributo(
                    'Movimento',
                    'Cheio',
                    atributos['Movimento']!,
                    (valor) => setAtributo('Movimento', valor),
                  ),
                  buildAtributo(
                    'Kick-Out',
                    'Bem Capaz',
                    atributos['Kick-Out']!,
                    (valor) => setAtributo('Kick-Out', valor),
                  ),
                  // Botão de prosseguir
                
                ],
              ),
            ),
          )
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),

        // Avaliação por imagens customizadas
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza os ícones
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0,), // Ajustado para um espaçamento menor
              child: IconButton(
                icon: Image.asset(
                  'lib/assets/iconPico.png', // Substitua pelo caminho da sua imagem
                  color: index < valor ? Color(0xFF8B0000) : Colors.grey[300], // Altera a cor do ícone baseado na avaliação
                ),
                iconSize: 50, // Tamanho aumentado para 50
                onPressed: () {
                  onChanged(index + 1); // Atualiza o valor do atributo
                },
              ),
            );
          }),
        ),

        // Descrição abaixo dos ícones
        Text(
          descricao,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),

        SizedBox(height: 7),
      ],
    );
  }
}
