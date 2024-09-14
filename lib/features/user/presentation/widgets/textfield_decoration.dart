import 'package:flutter/material.dart';

InputDecoration customTextField(String label) {
    return InputDecoration(
        
        label: Text(label),
        filled: true,
        fillColor: const Color.fromARGB(255, 139, 0, 0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        labelStyle:const TextStyle(
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.all(20.0),
        errorText: label.isEmpty ? 'Insira os campos' : null,
      );
}