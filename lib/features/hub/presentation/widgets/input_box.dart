import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  final Future<void> Function(String) sendAction;
  final void Function() chooseAction;
  const InputBox(
      {super.key, required this.sendAction, required this.chooseAction});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController postController = TextEditingController();
  Future<void> Function(String) get sendAction => widget.sendAction;
  void Function() get chooseAction => widget.chooseAction;

  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
      child: Stack(
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
                      color: Color.fromARGB(139, 12, 12, 12),
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
                focusColor: isTapped
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
                icon: const Icon(Icons.send_rounded, color:  Color.fromARGB(255, 128, 25, 18),),
                iconSize: 30,
                onPressed: () async => sendAction(postController.text),
                disabledColor: const Color.fromARGB(255, 255, 72, 0)),
          ),
        ],
      ),
    );
  }
}
