import 'package:demopico/core/app/theme/theme.dart';
import 'package:flutter/material.dart';

class ObstacleWidget extends StatefulWidget {
  final List<String> obstacles;
  const ObstacleWidget({super.key, required this.obstacles});

  @override
  State<ObstacleWidget> createState() => _ObstacleWidgetState();
}

class _ObstacleWidgetState extends State<ObstacleWidget> {
  final Map<String, String> obstaculosMap = {
    "45° graus": "assets/images/icons/45graus.png",
    "Barreira newjersey": "assets/images/icons/barreira.png",
    "Bowl zão": "assets/images/icons/bowl.png",
    "Banco": "assets/images/icons/cadeira.png",
    "Corrimão": "assets/images/icons/corrimao.png",
    "Escada": "assets/images/icons/escada.png",
    "Funbox": "assets/images/icons/funbox.png",
    "Gap": "assets/images/icons/gap.png",
    "Jump": "assets/images/icons/jump.png",
    "Megaramp": "assets/images/icons/megaramp.png",
    "Miniramp": "assets/images/icons/miniramp.png",
    "Pirâmide": "assets/images/icons/piramede.png",
    "Quarter": "assets/images/icons/quarter.png",
    "Spine": "assets/images/icons/spine.png",
    "Stepper": "assets/images/icons/stepper.png",
    "Transição": "assets/images/icons/transição.png",
    "Hidrante": "assets/images/icons/hidrante.png",
    "Parede": "assets/images/icons/wallObstaculo.png",
    "Bowl zinho": "assets/images/icons/bowl.png",
    "Lixeira": "assets/images/icons/lixeira.png",
    "Icone21": "assets/images/icons/icone21.png",
    "Icone22": "assets/images/icons/icone22.png",
    "Icone23": "assets/images/icons/icone23.png",
    "Icone24": "assets/images/icons/icone24.png",
    "Icone25": "assets/images/icons/icone25.png",
    "Icone26": "assets/images/icons/icone26.png",
    "Icone27": "assets/images/icons/icone27.png",
    "Icone28": "assets/images/icons/icone28.png",
    "Icone29": "assets/images/icons/icone29.png",
    "Icone30": "assets/images/icons/icone30.png",
    "Icone31": "assets/images/icons/icone31.png",
    "Icone32": "assets/images/icons/icone32.png",
    "Icone33": "assets/images/icons/icone33.png",
    "Icone34": "assets/images/icons/icone34.png",
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        widget.obstacles.length,
        (index) {
          String obstaculo = widget.obstacles[index];
          String? iconPath = obstaculosMap[obstaculo];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: iconPath != null
                ? Image.asset(
                    iconPath,
                    width: 30, 
                    height: 30, 
                  )
                : const Icon(
                    Icons.broken_image_rounded, // Ícone padrão caso o obstáculo não exista no Map
                    color: kRedAccent,
                  ),
          );
        },
      ),
    );
  }
}
