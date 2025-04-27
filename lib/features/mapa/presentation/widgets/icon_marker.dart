
import 'package:flutter/material.dart';







class IconMarker extends StatelessWidget {
  const IconMarker({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Image(
          image: AssetImage(
            "assets/images/Location.png",
          ),
          height: 350,
          width: 350,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }
}




