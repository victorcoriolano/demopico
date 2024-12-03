import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SegundaTela extends StatefulWidget {
  const SegundaTela({super.key});

  @override
  _SegundaTelaState createState() => _SegundaTelaState();
}

class _SegundaTelaState extends State<SegundaTela> {
  // Função para mapear os valores de 1 a 5 para a descrição do atributo 'Chão'
  String obterDescricaoChao(int nota) {
    switch (nota) {
      case 5:
        return 'Patinete';
      case 4:
        return 'Lisinho';
      case 3:
        return 'Suave';
      case 2:
        return 'Pedrinhas';
      case 1:
        return 'Esburacado';
      default:
        return 'Descrição Indefinida';
    }
  }

// Função para mapear os valores de 1 a 5 para a descrição do atributo 'Iluminação'
  String obterDescricaoIluminacao(int nota) {
    switch (nota) {
      case 5:
        return 'Muito Claro';
      case 4:
        return 'Clarinho';
      case 3:
        return 'Razoável';
      case 2:
        return 'Pouca Luz';
      case 1:
        return 'Escuro';
      default:
        return 'Descrição Indefinida';
    }
  }

// Função para mapear os valores de 1 a 5 para a descrição do atributo 'Policiamento'
  String obterDescricaoPoliciamento(int nota) {
    switch (nota) {
      case 5:
        return 'Opressão';
      case 4:
        return 'Boqueta';
      case 3:
        return 'Pala';
      case 2:
        return 'Toma Cuidado';
      case 1:
        return 'Suave';
      default:
        return 'Descrição Indefinida';
    }
  }

// Função para mapear os valores de 1 a 5 para a descrição do atributo 'Movimento'
  String obterDescricaoMovimento(int nota) {
    switch (nota) {
      case 5:
        return 'Muito Cheio';
      case 4:
        return 'Cheio';
      case 3:
        return 'Médio';
      case 2:
        return 'Calmo';
      case 1:
        return 'Vazio';
      default:
        return 'Descrição Indefinida';
    }
  }

// Função para mapear os valores de 1 a 5 para a descrição do atributo 'Kick-Out'
  String obterDescricaoKickOut(int nota) {
    switch (nota) {
      case 5:
        return 'Muito Capaz';
      case 4:
        return 'Bem Capaz';
      case 3:
        return 'Moderado';
      case 2:
        return 'Improvável';
      case 1:
        return 'Impossível';
      default:
        return 'Descrição Indefinida';
    }
  }

  // Variáveis para armazenar a avaliação de cada atributo (0 a 5)

/*
  // Função para definir o valor de cada atributo
  void setAtributo(String atributo, int valor) {
    setState(() {
      atributos[atributo] = valor; // Atualiza o valor do atributo selecionado
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPicoControllerProvider>(
      builder: (context, provider, child) => Scaffold(
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
                      child: Image.asset(
                        'assets/images/progresso2.png',
                      ),
                    ),
                  ),

                  // Widget de cada atributo com descrição abaixo dos ícones
                  Container(
                    margin: EdgeInsets.only(top:10, bottom: 25),
                    child: buildAtributo(
                      'CHÃO',
                      obterDescricaoChao(provider.atributos['Chão']!),
                      provider.atributos['Chão']!,
                      (valor) => provider.atualizarAtributo('Chão', valor),
                    ),
                  ),

                  buildAtributo(
                    'ILUMINAÇÃO',
                    obterDescricaoIluminacao(provider.atributos['Iluminação']!),
                    provider.atributos['Iluminação']!,
                    (valor) => provider.atualizarAtributo('Iluminação', valor),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 25),
                    child: buildAtributo(
                      'POLICIAMENTO',
                      obterDescricaoPoliciamento(
                          provider.atributos['Policiamento']!),
                      provider.atributos['Policiamento']!,
                      (valor) =>
                          provider.atualizarAtributo('Policiamento', valor),
                    ),
                  ),

                  buildAtributo(
                    'MOVIMENTO',
                    obterDescricaoMovimento(provider.atributos['Movimento']!),
                    provider.atributos['Movimento']!,
                    (valor) => provider.atualizarAtributo('Movimento', valor),
                  ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                    child: buildAtributo(
                      'KICK-OUT',
                      obterDescricaoKickOut(provider.atributos['Kick-Out']!),
                      provider.atributos['Kick-Out']!,
                      (valor) => provider.atualizarAtributo('Kick-Out', valor),
                    ),
                  ),
                ],
              ),
            ),
          )),
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
              padding: const EdgeInsets.all(
                  0.0), // Ajustado para um espaçamento menor
              child: IconButton(
                  icon: Image.asset(
                    height:
                        40.0, // diminuindo o tamanho do icon para n ficar dando erro
                    width: 42.0,
                    'assets/images/iconPico.png', // Substitua pelo caminho da sua imagem
                    color: index < valor
                        ? const Color(0xFF8B0000)
                        : Colors.grey[
                            350], // Altera a cor do ícone baseado na avaliação
                  ),
            
                  onPressed: () {
                    onChanged(index + 1); // Atualiza o valor do atributo
                  }),
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
