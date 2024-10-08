import 'package:flutter/material.dart';

class EspecificidadeScreen extends StatefulWidget {
  const EspecificidadeScreen({super.key});

  @override
  State<EspecificidadeScreen> createState() => _EspecificidadeScreenState();
}

class _EspecificidadeScreenState extends State<EspecificidadeScreen> {
  // Variáveis para armazenar o valor selecionado do dropdown e a modalidade escolhida
  String selectedModalidade = 'Skate';
  String dropdownValue = 'Pico de Rua';

  // Mapa que define as utilidades para cada modalidade
  Map<String, List<String>> utilidadesPorModalidade = {
    'Skate': ['Água', 'Teto', 'Banheiro', 'Suave f1', 'Público / Gratuito'],
    'Parkour': ['Água', 'Banheiro', 'Mecânicas Próximas', 'Ar Livre'],
    'BMX': ['Água'],
  };

  List<String> utilidadesAtuais = []; // Lista de utilidades atuais da modalidade selecionada
  Map<String, bool> utilidadesSelecionadas = {}; // Mapa para rastrear quais utilidades estão selecionadas

  @override
  void initState() {
    super.initState();
    // Inicializa as utilidades para a modalidade selecionada
    utilidadesAtuais = utilidadesPorModalidade[selectedModalidade] ?? [];
    // Preenche o mapa de utilidades selecionadas como false inicialmente
    utilidadesAtuais.forEach((utilidade) {
      utilidadesSelecionadas[utilidade] = false;
    });
  }

  // Função para atualizar as utilidades com base na modalidade selecionada
  void atualizarUtilidades(String modalidade) {
    setState(() {
      selectedModalidade = modalidade; // Atualiza a modalidade selecionada
      utilidadesAtuais = utilidadesPorModalidade[modalidade] ?? []; // Atualiza as utilidades atuais
      utilidadesSelecionadas.clear(); // Limpa as seleções anteriores
      // Preenche novamente o mapa de utilidades selecionadas
      utilidadesAtuais.map((utilidade) {
        utilidadesSelecionadas[utilidade] = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Para o dialog ajustar o tamanho ao conteúdo
            children: [
              
                    // Imagem do topo
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Image.asset('assets/images/progresso1.png', ),
                      ),
                    ),
                    // Título da seção de modalidades
                    const Text(
                      'MODALIDADE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B0000),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Botões para seleção da modalidade
                    ModalidadeButtons(
                      onSelected: (String modalidade) {
                        atualizarUtilidades(modalidade); // Atualiza utilidades ao selecionar uma modalidade
                      },
                      selectedModalidade: selectedModalidade,
                    ),
                    const SizedBox(height: 20),
                    // Título da seção de tipo de pico
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'TIPO DE PICO:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                       color: Color(0xFF8B0000),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Dropdown para seleção do tipo de pico
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child:Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                                menuWidth: 400,  
                                dropdownColor: Colors.white,         
                                value: dropdownValue,
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!; // Atualiza o valor do dropdown
                                  });
                                },
                                items: <String>['Pico de Rua', 'Half', 'Bowl', 'Street', 'SkatePark']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    
                                    value: value,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 15,   color: Color.fromARGB(255, 0, 0, 0),),
                                      ),
                                    ),
                                  );
                                }).toList(),
                          underline: SizedBox(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Título da seção de utilidades
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'UTILIDADES',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B0000),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Lista de utilidades com checkboxes
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: utilidadesAtuais.map((utilidade) {
                            return CheckboxListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Text(utilidade), // Nome da utilidade
                              value: utilidadesSelecionadas[utilidade], // Valor do checkbox
                              onChanged: (bool? value) {
                                setState(() {
                                  utilidadesSelecionadas[utilidade] = value!; // Atualiza seleção
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Botão de prosseguir
                  
                  ],
                );
  }
}



// Widget para os botões de modalidade
class ModalidadeButtons extends StatelessWidget {
  final Function(String) onSelected; // Callback para seleção da modalidade
  final String selectedModalidade; // Modalidade selecionada

  ModalidadeButtons({required this.onSelected, required this.selectedModalidade});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espaçamento uniforme entre os botões
      children: [
        // Botão para modalidade Skate
        _buildModalidadeButton('Skate'),
        // Botão para modalidade Parkour
        _buildModalidadeButton('Parkour'),
        // Botão para modalidade BMX
        _buildModalidadeButton('BMX'),
      ],
    );
  }

  // Método para construir cada botão de modalidade
  Widget _buildModalidadeButton(String modalidade) {
    bool isSelected = selectedModalidade == modalidade; // Verifica se a modalidade está selecionada
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFF8B0000) : Colors.grey[300], // Cor do botão
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordas arredondadas
        ),
      ),
      onPressed: () {
        onSelected(modalidade); // Chama o callback com a modalidade selecionada
      },
      child: Text(modalidade, style: TextStyle(fontSize: 15)),
    );
  }
}
