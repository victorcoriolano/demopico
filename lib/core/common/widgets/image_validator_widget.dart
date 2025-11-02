import 'package:flutter/material.dart';

class ImageValidatorWidget extends StatelessWidget {
 const ImageValidatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('VERIFICANDO IMAGEM(S)'),
      titlePadding: EdgeInsets.all(0),
      content: Center(
          child: const SizedBox(
        width: 48,
        height: 48,
        child: CircularProgressIndicator(strokeWidth: 3),
      )),
    );
  }
}
