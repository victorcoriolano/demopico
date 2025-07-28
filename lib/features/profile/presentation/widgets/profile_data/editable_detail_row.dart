import 'package:demopico/core/app/theme/theme.dart';
import 'package:flutter/material.dart';

class EditableDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final TextEditingController controller;
  final bool isEditing;
  final VoidCallback onToggleEdit;
  final bool isPassword;
  final TextInputType keyboardType;


  const EditableDetailRow({
    super.key,
    required this. label,
    required this. value,
    required this. controller,
    required this. isEditing,
    required this. onToggleEdit,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState:
                      isEditing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  firstChild: Text(
                    value,
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  secondChild: TextField(
                    controller: controller,
                    style: TextStyle(color: kBlack, fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Digite o novo $label',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kRed),
                      ),
                      contentPadding: EdgeInsets.zero, // Remove default padding
                    ),
                    keyboardType: keyboardType,
                    obscureText: isPassword && !isEditing, // Obscure text only when not editing password
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isEditing ? Icons.check : Icons.edit,
                  color: Colors.grey,
                ),
                onPressed: onToggleEdit,
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey[800], height: 1), // Separator line
      ],
    );
  }
}