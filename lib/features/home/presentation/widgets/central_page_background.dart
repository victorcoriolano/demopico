import 'package:flutter/material.dart';

class CentralPageBackground extends StatelessWidget {
  const CentralPageBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
          height: MediaQuery.maybeSizeOf(context)!.height,
          width: MediaQuery.maybeSizeOf(context)!.width,
          decoration: BoxDecoration(
              gradient: RadialGradient(radius: 0.8, colors: [
            Color.fromARGB(255, 255, 157, 157),
            Color.fromARGB(255, 235, 152, 152),
            Color.fromARGB(255, 237, 185, 185),
            Color.fromARGB(255, 230, 174, 174),
            Color.fromARGB(255, 222, 188, 188),
            Color.fromARGB(255, 232, 212, 212),
            Color.fromARGB(255, 232, 232, 232),
            Color.fromARGB(255, 252, 248, 248),
            Color.fromARGB(255, 239, 239, 239)
          ], stops: [
            0.2,
            0.3,
            0.4,
            0.5,
            0.6,
            0.7,
            0.8,
            0.9,
            1.0
          ])));
  }
}

