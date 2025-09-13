import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SegundaTela extends StatefulWidget {
  const SegundaTela({super.key});

  @override
  State<SegundaTela> createState() => _SegundaTelaState();
}

class _SegundaTelaState extends State<SegundaTela> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: SingleChildScrollView(
            child: AttributesWidget(),
          ),
        ));
  }

  // Widget para construir cada linha de atributo
  }

class AttributesWidget extends StatelessWidget {
  
  const AttributesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPicoViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os itens
          children: [
            ...List.generate(viewModel.attributesVO.getAttributesList.length, (index) {
              //final nameAttribute = attributesVO.getAttributesList[index];
              final attributeEntry = viewModel.attributesVO.attributes.entries.elementAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os itens
          children: [
            Text(
              '${viewModel.attributesVO.getAttributesList[index]}:',
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
                            40.0,
                        width: 42.0,
                        'assets/images/iconPico.png', 
                        color: index < attributeEntry.value
                            ? kRed
                            : Colors.grey[
                                350],
                      ),
                
                      onPressed: () {
                        viewModel.updateAttribute(attributeEntry.key, index + 1); // Atualiza o valor do atributo
                      }),
                );
              }),
            ),
        
            // Descrição abaixo dos ícones
            Text(
              viewModel.getDescription(attributeEntry.key, attributeEntry.value),
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          ],
              );
            } ),
            // Nome do atributo
            
            const SizedBox(height: 7),  
          ],
        );
      }
    );
  }
}
