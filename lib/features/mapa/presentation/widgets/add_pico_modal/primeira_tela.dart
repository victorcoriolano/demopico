import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/domain/value_objects/modality_vo.dart';
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
      builder: (context, viewModel, child) => SingleChildScrollView(
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
              onSelected: (ModalitySpot selected) {
                viewModel.atualizarModalidade(
                    selected); // Atualiza utilidades ao selecionar uma modalidade
              },
              selectedModalidade: viewModel.selectedModalidade,
            ),
            const SizedBox(height: 20),
            // Título da seção de tipo de pico
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'TIPO DO LOCAL:',
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
                  dropdownColor: kAlmostWhite,
                  value: viewModel.typeSpotVo.selectedValue,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    if (newValue != null) viewModel.updateTypeSpot(newValue);
                  },
                  items: viewModel.typeSpotVo.options
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          value,
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
              children: viewModel.selectedModalidade.utilitiesByModality
                  .map((utilidade) {
                return CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(utilidade), // Nome da utilidade
                  value: viewModel
                      .utilidadesSelecionadas[utilidade], // Valor do checkbox
                  onChanged: (bool? valor) {
                    viewModel.selecionarUtilidade(utilidade, valor!);
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
  final Function(ModalitySpot) onSelected;
  final ModalitySpot selectedModalidade;

  const ModalidadeButtons(
      {super.key, required this.onSelected, required this.selectedModalidade});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ModalidadeItens(
            isSelectedModalidade: selectedModalidade == ModalitySpot.skate,
            modalidade: ModalitySpot.skate,
            onPressed: onSelected),
        ModalidadeItens(
            isSelectedModalidade: selectedModalidade == ModalitySpot.bmx,
            modalidade: ModalitySpot.bmx,
            onPressed: onSelected),
        ModalidadeItens(
            isSelectedModalidade: selectedModalidade == ModalitySpot.parkour,
            modalidade: ModalitySpot.parkour,
            onPressed: onSelected),
      ],
    );
  }
}

class ModalidadeItens extends StatelessWidget {
  final bool isSelectedModalidade;
  final ModalitySpot modalidade;
  final Function(ModalitySpot) onPressed;
  const ModalidadeItens({
    super.key,
    required this.isSelectedModalidade,
    required this.modalidade,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelectedModalidade
            ? const Color(0xFF8B0000)
            : Colors.grey[300],
        foregroundColor: isSelectedModalidade ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), 
        ),
      ),
      onPressed: () => onPressed(modalidade), // Chama o callback com a modalidade selecionada
      child: Text(modalidade.name, style: const TextStyle(fontSize: 15)),
    );
  }
}
