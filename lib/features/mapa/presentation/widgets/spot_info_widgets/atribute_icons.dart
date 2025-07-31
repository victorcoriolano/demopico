import 'package:flutter/material.dart';

class AtributeIcons extends StatefulWidget {
  final int value;
  const AtributeIcons({ super.key, required this.value });

  @override
  State<AtributeIcons> createState() => _AtributeIconsState();
}

class _AtributeIconsState extends State<AtributeIcons> {

   @override
   Widget build(BuildContext context) {
       return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        children: [
          // Gerando 5 ícones
          ...List.generate(5, (index) {
            return Image.asset(
              'assets/images/iconPico.png',
              color: index < widget.value
                  ? const Color.fromARGB(255, 169, 41, 41)
                  : Colors.grey,
              width: 28,
            );
          }),
        ],
      ),
    ]);
  }
}