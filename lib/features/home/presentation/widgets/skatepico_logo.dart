import 'package:flutter/material.dart';

class SkatePicoLogo extends StatelessWidget {
  const SkatePicoLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..setRotationZ(10.2),
        child: Image.asset('assets/images/skatepico-icon.png',
            filterQuality: FilterQuality.high, width: 150, height: 150),
      ),
    );
  }
}
