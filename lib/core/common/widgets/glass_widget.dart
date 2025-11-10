import 'dart:ui';

import 'package:flutter/material.dart';

class GlassWidget extends StatelessWidget {
  final Widget child;
  const GlassWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRect(

      child: BackdropFilter(
        
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2), // Cor com transparência
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5), // Borda translúcida
              width: 2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
