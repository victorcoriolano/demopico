
import 'package:flutter/material.dart';

ButtonStyle buttonStyle(){
  return ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll(Color.fromARGB(255, 139, 0, 0),),
    fixedSize: const WidgetStatePropertyAll(Size(170, 35)),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),),
    textStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.white)),
    
  );
}

