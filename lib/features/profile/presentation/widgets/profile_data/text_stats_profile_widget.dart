import 'package:demopico/core/app/theme/theme.dart';
import 'package:flutter/material.dart';

class TextStatsProfileWidget extends StatefulWidget {
  final String info;
  final String legend; 
  const TextStatsProfileWidget({super.key, required this.info, required this.legend});

  @override
  State<TextStatsProfileWidget> createState() => _TextStatsProfileWidgetState();
}

class _TextStatsProfileWidgetState extends State<TextStatsProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: kAlmostWhite,
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Column(
              children: [
                Text(
                  widget.info,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.legend,
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 1,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
    );
  }
}