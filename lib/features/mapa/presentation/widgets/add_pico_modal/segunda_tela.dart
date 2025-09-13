import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/domain/value_objects/attributes_vo.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_view_model.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/atribute_icons.dart';
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
    return Consumer<AddPicoViewModel>(
      builder: (context, provider, child) => Scaffold(
          backgroundColor: Colors.grey[200],
          body: Center(
            child: SingleChildScrollView(
              child: AttributesWidget(attributesVO: provider.attributesVO)
            ),
          )),
    );
  }

  // Widget para construir cada linha de atributo
  }

class AttributesWidget extends StatelessWidget {
  final AttributesVO attributesVO;
  const AttributesWidget({super.key, required this.attributesVO});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os itens
      children: [
        ...List.generate(attributesVO.getAttributesList.length, (index) {
          final nameAttribute = attributesVO.getAttributesList[index];
          final attributeEntry = attributesVO.attributes.entries.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os itens
      children: [
        Text(
          '$nameAttribute:',
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
                    color: index < attributesVO.attributes.values.toList()[index]
                        ? kRed
                        : Colors.grey[
                            350],
                  ),
            
                  onPressed: () {
                    attributesVO.updateRate(attributeEntry.key, index + 1); // Atualiza o valor do atributo
                  }),
            );
          }),
        ),

        // Descrição abaixo dos ícones
        Text(
          attributesVO.obterDescricao(attributeEntry.key, attributeEntry.value),
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
}
