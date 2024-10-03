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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: screenWidth * 0.9, // Ajuste relativo à largura da tela
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF8B0000), width: 3),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Imagem no topo
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Image.asset(
                      'lib/assets/addPico2.png',
                      height: screenHeight * 0.2, // Ajuste dinâmico para a imagem (aumentada para 20%)
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

                  SizedBox(height: 20),

                  // Botão de voltar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8B0000), // Mesma cor que o botão "Prosseguir"
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Voltar para a tela anterior
                      Navigator.pop(context);
                    },
                    child: Text('VOLTAR', style: TextStyle(fontSize: 15)),
                  ),

                  SizedBox(height: 10), // Espaçamento entre os botões

                  // Botão de prosseguir
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8B0000), // Mesma cor
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Navegar para a Terceira Tela
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TerceiraTela()),
                      );
                    },
                    child: Text('PROSSEGUIR', style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
          ),
        ),
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
