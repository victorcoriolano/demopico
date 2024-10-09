import 'package:demopico/features/user/presentation/widgets/button_custom.dart';
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
  body: Column(
    children: [
      // A imagem ficará fora da rolagem
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(
          'assets/images/progresso2.png',
        ),
      ),
      // O restante dos widgets ficará dentro da rolagem
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
            ],
          ),
        ),
      ),
    ],
  ),
);

        
  }

  // Widget para construir cada linha de atributo
  Widget buildAtributo(
      String titulo, String descricao, int valor, Function(int) onChanged) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          // Centraliza os ícones
          children: List.generate(5, (index) {
            // Ajustado para um espaçamento menor
            return SizedBox(
              width: 70,
              child: Container(
                margin: EdgeInsets.only(bottom: 10, top: 5),
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/iconPico.png', // Substitua pelo caminho da sua imagem
                    color: index < valor
                        ? Color(0xFF8B0000)
                        : Colors.grey[
                            300], // Altera a cor do ícone baseado na avaliação
                  ),
                  iconSize: 10, // Tamanho aumentado para 50
                  onPressed: () {
                    onChanged(index + 1); // Atualiza o valor do atributo
                  },
                ),
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

        SizedBox(height: 30),
      ],
    );
  }
}
