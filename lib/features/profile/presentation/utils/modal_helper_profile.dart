
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModalHelperProfile {
  static void confirmDiscardingChanges(BuildContext context){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Deseja descartar as alterações?"),
          actions: [
            TextButton(
                  child: const Text('CANCELAR'),
                  onPressed: () {
                    Get.back();
                  },
                ),
                TextButton(
                  child: const Text('Confirmar'),
                  onPressed: () async {
                    Get.back();
                    Get.back();
                  },
                ),
          ],
        );
      },
    );
  }
}