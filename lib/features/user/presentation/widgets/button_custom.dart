
import 'package:flutter/material.dart';

ButtonStyle buttonStyle(){
  return ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll(Color(0xFF8B0000),),
    fixedSize: const WidgetStatePropertyAll(Size(170, 35)),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),),
    textStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.white)),
    
  );
}

