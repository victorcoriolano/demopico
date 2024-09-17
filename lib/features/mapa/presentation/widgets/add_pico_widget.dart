import 'package:flutter/material.dart';

class AddPicoWidget extends StatelessWidget {
  const AddPicoWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(onPressed: onPressed,
    backgroundColor: Color.fromARGB(255, 139, 0, 0),
    child: const Center(
      child: Icon(Icons.add) ,
    ),
    
    );
  }
}