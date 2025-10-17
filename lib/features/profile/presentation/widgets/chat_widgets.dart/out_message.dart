import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/presentation/widgets/chat_widgets.dart/triangle.dart';
import 'package:flutter/material.dart';

class OutMessage extends StatelessWidget {
  final String message;
  const OutMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: kRed,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(19),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        CustomPaint(painter: Triangle(kRed)),
      ],
    );
  }
}