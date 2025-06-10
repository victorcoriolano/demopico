import 'package:flutter/material.dart';

class EditFieldDialog extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final VoidCallback onConfirm;
  final String confirmText;
  final String cancelText;

  const EditFieldDialog({
    super.key,
    required this.title,
    required this.controller,
    required this.onConfirm,
    this.confirmText = 'Salvar',
    this.cancelText = 'Cancelar',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
      content: TextField(controller: controller),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(cancelText, style: const TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onConfirm();
              Navigator.of(context).pop();
            }
          },
          child: Text(confirmText, style: const TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
