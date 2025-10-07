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
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4.0,
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.serverImage),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 10),
            Text(
              widget.serverName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
