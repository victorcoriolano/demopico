import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputBox extends StatefulWidget {
  final Future<bool> Function(String) sendAction;
  final void Function() chooseAction;
  const InputBox(
      {super.key, required this.sendAction, required this.chooseAction});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController postController = TextEditingController();
  Future<bool> Function(String) get sendAction => widget.sendAction;
  void Function() get chooseAction => widget.chooseAction;

  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          child: Container(
            height: 90,
            width: 350,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(35)),
              color: Color.fromARGB(255, 217, 217, 217),
            ),
          ),
        ),
        Positioned(
          top: -9,
          right: -18,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: const Color.fromARGB(255, 217, 217, 217),
            ),
          ),
        ),
        Positioned(
          top: -9,
          left: -18,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: const Color.fromARGB(255, 217, 217, 217),
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 30,
          child: SizedBox(
            width: 185,
            height: 70,
            child: TextField(
              style: const TextStyle(
                  decoration: TextDecoration.none, overflow: TextOverflow.clip),
              decoration: const InputDecoration(
                helperStyle: TextStyle(),
                counterText: '',
                enabledBorder: null,
                hintText: 'Fazer anúncio...',
                hintStyle: TextStyle(
                    color: Color.fromARGB(64, 12, 12, 12),
                    fontWeight: FontWeight.bold),
              ),
              controller: postController,
              maxLines: 5,
              maxLength: 200,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top,
              minLines: 1,
            ),
          ),
        ),
        Positioned(
          top: 18,
          right: 56,
          child: IconButton(
            isSelected: isTapped,
            selectedIcon: const Icon(Icons.blur_on_outlined),
            icon: const Icon(Icons.keyboard_arrow_up),
            color: isTapped
                ? const Color.fromARGB(255, 74, 178, 230)
                : const Color.fromARGB(255, 0, 0, 0),
            iconSize: 45,
            onPressed: chooseAction,
          ),
        ),
        Positioned(
          top: 23,
          right: 8,
          child: IconButton(
              icon: const Icon(Icons.send_rounded, color: Colors.black),
              iconSize: 30,
              onPressed: () async {
                try {
                  await sendAction(postController.text).then(
                      (value) => value == true ? null : throw Exception());
                  postController.clear();
                } on Exception catch (_) {
                  if (Exception is FirebaseAuthException) {
                    Get.snackbar('Erro de Usuário',
                        'Por favor, entre para fazer uma publicação',
                        backgroundColor: const Color.fromARGB(255, 122, 49, 49),
                        snackPosition: SnackPosition.BOTTOM);
                  }
                  if (Exception is FormatException) {
                    Get.snackbar('Erro de Formato',
                        'O texto e o tipo da publicação são obrigatórios.',
                        backgroundColor: const Color.fromARGB(255, 122, 49, 49),
                        snackPosition: SnackPosition.BOTTOM);
                  }
                  if (Exception is FirebaseException ||
                      Exception is UnimplementedError) {
                    Get.snackbar('Erro Inesperado',
                        'Um erro inesperado aconteceu. Por favor, tente novamente.',
                        backgroundColor: const Color.fromARGB(255, 122, 49, 49),
                        snackPosition: SnackPosition.BOTTOM);
                  }
                }
                await Future.delayed(const Duration(milliseconds: 300));
                return;
              },
              disabledColor: const Color.fromARGB(255, 255, 72, 0)),
        ),
      ],
    );
  }
}
