import 'dart:math';

import 'package:demopico/features/profile/presentation/widgets/chat_widgets.dart/triangle.dart';
import 'package:flutter/material.dart';

class InMessage extends StatelessWidget {
  final String message;
  const InMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: CustomPaint(
            painter: Triangle(Colors.grey.shade300),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(19),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}