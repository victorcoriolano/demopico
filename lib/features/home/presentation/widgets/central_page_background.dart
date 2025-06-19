import 'package:flutter/material.dart';

class CentralPageBackground extends StatelessWidget {
  const CentralPageBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.maybeSizeOf(context)!.height * 0.9,
        width: MediaQuery.maybeSizeOf(context)!.width,
        decoration: BoxDecoration(
            gradient: RadialGradient(radius: 0.8, colors: [
          Color(0xFFD9D9D9),
          Color(0xFFE7E7E7),
          Color(0xFFECECEC),
          Color(0xFFEBEBEB),
          Color(0xFFF9F9F9)
        ], stops: [
          0.2,
          0.3,
          0.4,
          0.5,
          1.0
        ])),
        child: Center(
            child: Row(
          children: [
            Icon(Icons.chevron_left, size: 64),
            Spacer(),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..setRotationZ(10.2),
              child: Image.asset('assets/images/skatepico-icon.png',
                  filterQuality: FilterQuality.high,
                  width: 150,
                  height: 150),
            ),
            Spacer(),
            Icon(Icons.chevron_right, size: 64),
          ],
        )));
  }
}


