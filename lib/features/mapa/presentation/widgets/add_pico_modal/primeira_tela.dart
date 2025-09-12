import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/value_objects/type_spot_vo.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EspecificidadeScreen extends StatefulWidget {

  const EspecificidadeScreen({super.key});

  @override
  State<EspecificidadeScreen> createState() => _EspecificidadeScreenState();
}

class _EspecificidadeScreenState extends State<EspecificidadeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddPicoViewModel>(
      builder: (context, value, child) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize:
              MainAxisSize.min, // Para o dialog ajustar o tamanho ao conteúdo
          children: [
            // Imagem do topo
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Image.asset(
                  'assets/images/progresso1.png',
                ),
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
            const SizedBox(height: 25),
            // Botões para seleção da modalidade
            ModalidadeButtons(
              onSelected: (String modalidade) {
                value.atualizarModalidade(
                    modalidade); // Atualiza utilidades ao selecionar uma modalidade
              },
              selectedModalidade: value.selectedModalidade.name,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  menuWidth: 400,
                  dropdownColor: Colors.white,
                  value: value.tipo.name,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    value.atualizarDropdown(newValue!);
                  },
                  items: 
                    
                  TypeSpotVo.options.map<DropdownMenuItem<String>>((TypeSpot value) {
                    return DropdownMenuItem<String>(
                      value: value.name,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          value.name,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  underline: const SizedBox(),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 10),
            // Lista de utilidades com checkboxes
            Column(
              children: value.selectedModalidade.utilitiesByModality.map((utilidade) {
                return CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(utilidade), // Nome da utilidade
                  value: value
                      .utilidadesSelecionadas[utilidade], // Valor do checkbox
                  onChanged: (bool? valor) {
                    value.selecionarUtilidade(utilidade, valor!);
                    if (valor == true) {
                      value.utilidades.add(utilidade);
                    } else {
                      value.utilidades.remove(utilidade);
                    }
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ModalidadeButtons extends StatelessWidget {
  final Function(String) onSelected; 
  final String selectedModalidade; 

  const ModalidadeButtons({super.key, required this.onSelected, required this.selectedModalidade});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
      children: [
        ModalidadeItens(isSelectedModalidade: selectedModalidade == "Skate", modalidade: "Skate", onPressed: onSelected),
        ModalidadeItens(isSelectedModalidade: selectedModalidade == "BMX", modalidade: "BMX", onPressed: onSelected),
        ModalidadeItens(isSelectedModalidade: selectedModalidade == "Parkour", modalidade: "Parkour", onPressed: onSelected),
      ],
    );
  }
}

class ModalidadeItens extends StatelessWidget {
  final bool isSelectedModalidade;
  final String modalidade;
  final Function(String) onPressed;
  const ModalidadeItens({super.key, required this.isSelectedModalidade, required this.modalidade, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelectedModalidade ? const Color(0xFF8B0000) : Colors.grey[300], // Cor do botão
        foregroundColor: isSelectedModalidade ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordas arredondadas
        ),
      ),
      onPressed: () => onPressed(modalidade), // Chama o callback com a modalidade selecionada
      child: Text(modalidade, style: const TextStyle(fontSize: 15)),
    );
  }
}
