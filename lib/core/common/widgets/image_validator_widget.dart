import 'package:flutter/material.dart';

class ImageValidatorWidget extends StatelessWidget {
 final bool isLoading;
  const ImageValidatorWidget({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Validação de Imagem"),
      content: Center(
        child: isLoading == true
            ? const SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(strokeWidth: 3),
              )
            : Icon(Icons.check_circle),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
