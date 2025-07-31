import 'package:flutter/material.dart';

class EvaluateWidget extends StatefulWidget {
  final double rate;
  final int numberReviews;
  const EvaluateWidget(
      {super.key, required this.rate, required this.numberReviews});

  @override
  State<EvaluateWidget> createState() => _EvaluateWidgetState();
}

class _EvaluateWidgetState extends State<EvaluateWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.rate.toStringAsFixed(2),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Row(
          children: List.generate(5, (index) {
            if (index < widget.rate.floor()) {
              // Estrela cheia
              return const Icon(Icons.star, color: Colors.black);
            } else if (index == widget.rate.floor() &&
                (widget.rate % 1) >= 0.5) {
              // Meia estrela se a parte decimal for >= 0.5
              return const Icon(Icons.star_half, color: Colors.black);
            } else {
              // Estrela vazia
              return const Icon(Icons.star, color: Colors.grey);
            }
          }),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                ' ${widget.numberReviews.toString()} avaliações',
                style: const TextStyle(
                    color: Color.fromARGB(255, 93, 93, 93), fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
