import 'package:flutter/material.dart';

class ServidoresCard extends StatefulWidget {
  final String serverName;
  final String serverImage;
  final VoidCallback onTap;
  final String servidorPath;

  const ServidoresCard({
    super.key,
    required this.serverName,
    required this.serverImage,
    required this.onTap,
    required this.servidorPath,
  });

  @override
  State<ServidoresCard> createState() => _ServidoresCardState();
}

class _ServidoresCardState extends State<ServidoresCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.5),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
          clipBehavior: Clip.antiAlias, 
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.serverImage),
                fit: BoxFit.cover, 
              ),
            ),
            child: Container(
              height: 70,
              color: Colors.black.withValues(alpha: 0.4),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              child: Text(
                widget.serverName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, 
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
